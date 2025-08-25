import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path/path.dart' as path;
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
  }) async {
    try {
      // Validate file size before download
      if (!await _validateFileSize(url, folderType)) {
        throw AppException.validation('File size exceeds limit');
      }

      onStatusUpdate?.call('Preparing download...');

      // Generate unique filename to avoid conflicts
      final uniqueFileName = AppUtils.generateUniqueFileName(fileName);
      
      // Get appropriate folder path
      final folderPath = await FileManager.getFolderPath(_getFolderName(folderType));
      final filePath = path.join(folderPath, uniqueFileName);

      onStatusUpdate?.call('Downloading...');

      // Download file
      await mediaRemoteDataSource.downloadFile(
        url,
        filePath,
        onReceiveProgress: onProgress,
      );

      onStatusUpdate?.call('Download completed');

      return filePath;
    } catch (e) {
      if (e is AppException) {
        rethrow;
      }
      throw AppException.unknown('Download failed: ${e.toString()}');
    }
  }

  Future<List<String>> downloadMultipleFiles({
    required List<DownloadItem> items,
    Function(int, int, String)? onProgress,
    Function(String)? onStatusUpdate,
  }) async {
    final downloadedPaths = <String>[];
    
    for (int i = 0; i < items.length; i++) {
      final item = items[i];
      
      try {
        onStatusUpdate?.call('Downloading ${item.fileName} (${i + 1}/${items.length})');
        
        final filePath = await downloadFile(
          url: item.url,
          fileName: item.fileName,
          folderType: item.folderType,
          onProgress: (received, total) {
            onProgress?.call(received, total, item.fileName);
          },
        );

        if (filePath != null) {
          downloadedPaths.add(filePath);
        }
      } catch (e) {
        // Log error but continue with other downloads
        print('Failed to download ${item.fileName}: $e');
      }
    }

    return downloadedPaths;
  }

  Future<bool> checkFileExists(String url) async {
    return await mediaRemoteDataSource.checkFileExists(url);
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

  Future<bool> _validateFileSize(String url, String folderType) async {
    final fileSize = await getFileSize(url);
    if (fileSize == null) return true; // Can't validate, allow download

    switch (folderType) {
      case 'image':
        return fileSize <= AppConstants.maxImageSize;
      case 'video':
        return fileSize <= AppConstants.maxVideoSize;
      case 'document':
        return fileSize <= AppConstants.maxDocumentSize;
      default:
        return fileSize <= AppConstants.maxDocumentSize;
    }
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

  Future<void> cancelDownload() async {
    // Implementation for canceling ongoing downloads
    // This would require maintaining download references
  }

  Future<List<String>> getDownloadedFiles(String folderType) async {
    final folderPath = await FileManager.getFolderPath(_getFolderName(folderType));
    final files = await FileManager.listFilesInFolder(folderPath);
    return files.where((f) => f is File).map((f) => f.path).toList();
  }

  Future<void> clearDownloads(String folderType) async {
    await FileManager.clearFolder(_getFolderName(folderType));
  }

  Future<int> getDownloadsFolderSize(String folderType) async {
    final folderPath = await FileManager.getFolderPath(_getFolderName(folderType));
    return await FileManager.getFolderSize(folderPath);
  }
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