import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path/path.dart' as path;
import 'package:dio/dio.dart';
import '../core/network/dio_client.dart';
import '../core/storage/file_manager.dart';
import '../core/constants/app_constants.dart';
import '../core/exceptions/app_exceptions.dart';
import '../core/utils/app_utils.dart';
import '../data/datasources/remote/media_remote_datasource.dart';

final downloadServiceProvider = Provider<DownloadService>((ref) {
  final dioClient = ref.read(dioClientProvider);
  final mediaRemoteDataSource = MediaRemoteDataSource(dioClient: dioClient);
  return DownloadService(
    dioClient: dioClient,
    mediaRemoteDataSource: mediaRemoteDataSource,
  );
});

class DownloadService {
  final DioClient dioClient;
  final MediaRemoteDataSource mediaRemoteDataSource;
  final Map<String, CancelToken> _activeTasks = {};

  DownloadService({
    required this.dioClient,
    required this.mediaRemoteDataSource,
  });

  Future<String?> downloadFile({
    required String url,
    required String fileName,
    required String folderType,
    Function(int, int)? onProgress,
    Function(String)? onStatusUpdate,
    String? taskId,
  }) async {
    final downloadTaskId = taskId ?? url.hashCode.toString();
    
    try {
      // Create cancel token for this download
      final cancelToken = CancelToken();
      _activeTasks[downloadTaskId] = cancelToken;

      // Validate URL
      if (url.isEmpty || !Uri.parse(url).isAbsolute) {
        throw AppException.validation('Invalid download URL');
      }

      onStatusUpdate?.call('Validating file...');

      // Check if file exists and get its size
      if (!await checkFileExists(url)) {
        throw AppException.notFound('File not found on server');
      }

      // Validate file size before download
      if (!await _validateFileSize(url, folderType)) {
        throw AppException.validation('File size exceeds ${_getMaxSizeForType(folderType)}MB limit');
      }

      onStatusUpdate?.call('Preparing download...');

      // Generate unique filename to avoid conflicts
      final uniqueFileName = AppUtils.generateUniqueFileName(fileName);
      
      // Get appropriate folder path
      final folderPath = await FileManager.getFolderPath(_getFolderName(folderType));
      final filePath = path.join(folderPath, uniqueFileName);

      // Check available space
      await _checkAvailableSpace(folderPath, url);

      onStatusUpdate?.call('Starting download...');

      // Download file with progress tracking
      await dioClient.download(
        url,
        filePath,
        cancelToken: cancelToken,
        onReceiveProgress: (received, total) {
          if (total > 0) {
            onProgress?.call(received, total);
          }
        },
      );

      // Verify downloaded file
      final file = File(filePath);
      if (!await file.exists()) {
        throw AppException.unknown('Download completed but file not found');
      }

      // Verify file size
      final fileSize = await file.length();
      if (fileSize == 0) {
        await file.delete();
        throw AppException.unknown('Downloaded file is empty');
      }

      onStatusUpdate?.call('Download completed');
      return filePath;

    } on DioException catch (e) {
      if (e.type == DioExceptionType.cancel) {
        throw AppException.unknown('Download was cancelled');
      } else if (e.type == DioExceptionType.connectionTimeout ||
                 e.type == DioExceptionType.receiveTimeout) {
        throw AppException.network('Download timeout. Please check your connection and try again.');
      } else {
        throw AppException.network('Download failed: ${e.message}');
      }
    } catch (e) {
      if (e is AppException) {
        rethrow;
      }
      throw AppException.unknown('Download failed: ${e.toString()}');
    } finally {
      _activeTasks.remove(downloadTaskId);
    }
  }

  Future<DownloadBatch> downloadMultipleFiles({
    required List<DownloadItem> items,
    Function(DownloadProgress)? onProgress,
    Function(String)? onStatusUpdate,
    String? batchId,
  }) async {
    final downloadBatchId = batchId ?? DateTime.now().millisecondsSinceEpoch.toString();
    final batch = DownloadBatch(id: downloadBatchId, items: items);
    
    try {
      for (int i = 0; i < items.length; i++) {
        final item = items[i];
        final taskId = '${downloadBatchId}_$i';
        
        try {
          onStatusUpdate?.call('Downloading ${item.fileName} (${i + 1}/${items.length})');
          
          final filePath = await downloadFile(
            url: item.url,
            fileName: item.fileName,
            folderType: item.folderType,
            taskId: taskId,
            onProgress: (received, total) {
              batch.updateProgress(i, received, total);
              onProgress?.call(DownloadProgress(
                currentItem: i,
                totalItems: items.length,
                currentFileName: item.fileName,
                currentReceived: received,
                currentTotal: total,
                batchReceived: batch.totalReceived,
                batchTotal: batch.totalSize,
              ));
            },
            onStatusUpdate: (status) {
              batch.updateItemStatus(i, status);
            },
          );

          if (filePath != null) {
            batch.completeItem(i, filePath);
          } else {
            batch.failItem(i, 'Download returned null path');
          }

        } catch (e) {
          batch.failItem(i, e.toString());
          // Continue with other downloads unless it's a critical error
          if (e is AppException) {
            break; // Stop all downloads if cancelled
          }
        }
      }

      batch.complete();
      return batch;

    } catch (e) {
      batch.fail(e.toString());
      throw AppException.unknown('Batch download failed: ${e.toString()}');
    }
  }

  Future<bool> checkFileExists(String url) async {
    try {
      final response = await dioClient.head(url);
      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }

  Future<int?> getFileSize(String url) async {
    try {
      final response = await dioClient.head(url);
      final contentLength = response.headers.value('content-length');
      return contentLength != null ? int.tryParse(contentLength) : null;
    } catch (e) {
      return null;
    }
  }

  Future<void> cancelDownload(String taskId) async {
    final cancelToken = _activeTasks[taskId];
    if (cancelToken != null && !cancelToken.isCancelled) {
      cancelToken.cancel('User cancelled download');
    }
  }

  Future<void> cancelAllDownloads() async {
    for (final token in _activeTasks.values) {
      if (!token.isCancelled) {
        token.cancel('All downloads cancelled');
      }
    }
    _activeTasks.clear();
  }

  Future<List<String>> getDownloadedFiles(String folderType) async {
    try {
      final folderPath = await FileManager.getFolderPath(_getFolderName(folderType));
      final files = await FileManager.listFilesInFolder(folderPath);
      return files.whereType<File>().map((f) => f.path).toList();
    } catch (e) {
      return [];
    }
  }

  Future<void> clearDownloads(String folderType) async {
    try {
      await FileManager.clearFolder(_getFolderName(folderType));
    } catch (e) {
      throw AppException.unknown('Failed to clear downloads: ${e.toString()}');
    }
  }

  Future<int> getDownloadsFolderSize(String folderType) async {
    try {
      final folderPath = await FileManager.getFolderPath(_getFolderName(folderType));
      return await FileManager.getFolderSize(folderPath);
    } catch (e) {
      return 0;
    }
  }

  // Private helper methods
  Future<bool> _validateFileSize(String url, String folderType) async {
    final fileSize = await getFileSize(url);
    if (fileSize == null) return true; // Can't validate, allow download

    final maxSize = _getMaxSizeInBytes(folderType);
    return fileSize <= maxSize;
  }

  Future<void> _checkAvailableSpace(String folderPath, String url) async {
    try {
      final fileSize = await getFileSize(url) ?? 0;
      final availableSpace = await FileManager.getFolderSize(folderPath);
      
      if (fileSize > 0 && availableSpace > 0 && fileSize > availableSpace) {
        throw AppException.validation('Not enough storage space available');
      }
    } catch (e) {
      // If we can't check space, proceed with download
      print('Warning: Could not check available space: $e');
    }
  }

  int _getMaxSizeInBytes(String folderType) {
    switch (folderType) {
      case 'image':
        return AppConstants.maxImageSize;
      case 'video':
        return AppConstants.maxVideoSize;
      case 'document':
        return AppConstants.maxDocumentSize;
      default:
        return AppConstants.maxDocumentSize;
    }
  }

  int _getMaxSizeForType(String folderType) {
    return (_getMaxSizeInBytes(folderType) / (1024 * 1024)).round();
  }

  String _getFolderName(String folderType) {
    switch (folderType) {
      case 'image':
        return AppConstants.imagesFolder;
      case 'video':
        return AppConstants.videosFolder;
      case 'document':
        return AppConstants.documentsFolder;
      default:
        return AppConstants.documentsFolder;
    }
  }

  bool get hasActiveDownloads => _activeTasks.isNotEmpty;
  
  List<String> get activeTaskIds => _activeTasks.keys.toList();
}

class DownloadItem {
  final String url;
  final String fileName;
  final String folderType;

  DownloadItem({
    required this.url,
    required this.fileName,
    required this.folderType,
  });
}

class DownloadProgress {
  final int currentItem;
  final int totalItems;
  final String currentFileName;
  final int currentReceived;
  final int currentTotal;
  final int batchReceived;
  final int batchTotal;

  DownloadProgress({
    required this.currentItem,
    required this.totalItems,
    required this.currentFileName,
    required this.currentReceived,
    required this.currentTotal,
    required this.batchReceived,
    required this.batchTotal,
  });

  double get currentProgress => currentTotal > 0 ? currentReceived / currentTotal : 0;
  double get batchProgress => batchTotal > 0 ? batchReceived / batchTotal : 0;
}

class DownloadBatch {
  final String id;
  final List<DownloadItem> items;
  final List<String?> _downloadedPaths;
  final List<String?> _errors;
  final List<String> _statuses;
  final List<int> _received;
  final List<int> _totals;
  bool _isCompleted = false;
  String? _batchError;

  DownloadBatch({required this.id, required this.items})
      : _downloadedPaths = List.filled(items.length, null),
        _errors = List.filled(items.length, null),
        _statuses = List.filled(items.length, 'Pending'),
        _received = List.filled(items.length, 0),
        _totals = List.filled(items.length, 0);

  void updateProgress(int index, int received, int total) {
    if (index >= 0 && index < items.length) {
      _received[index] = received;
      _totals[index] = total;
    }
  }

  void updateItemStatus(int index, String status) {
    if (index >= 0 && index < items.length) {
      _statuses[index] = status;
    }
  }

  void completeItem(int index, String filePath) {
    if (index >= 0 && index < items.length) {
      _downloadedPaths[index] = filePath;
      _statuses[index] = 'Completed';
    }
  }

  void failItem(int index, String error) {
    if (index >= 0 && index < items.length) {
      _errors[index] = error;
      _statuses[index] = 'Failed';
    }
  }

  void complete() {
    _isCompleted = true;
  }

  void fail(String error) {
    _isCompleted = true;
    _batchError = error;
  }

  // Getters
  List<String> get downloadedPaths => _downloadedPaths.where((p) => p != null).cast<String>().toList();
  List<String> get errors => _errors.where((e) => e != null).cast<String>().toList();
  List<String> get statuses => List.from(_statuses);
  bool get isCompleted => _isCompleted;
  String? get batchError => _batchError;
  bool get hasErrors => _errors.any((e) => e != null) || _batchError != null;
  
  int get completedCount => _downloadedPaths.where((p) => p != null).length;
  int get failedCount => _errors.where((e) => e != null).length;
  int get totalReceived => _received.fold(0, (sum, r) => sum + r);
  int get totalSize => _totals.fold(0, (sum, t) => sum + t);
  
  double get overallProgress {
    if (totalSize == 0) return 0;
    return totalReceived / totalSize;
  }
}