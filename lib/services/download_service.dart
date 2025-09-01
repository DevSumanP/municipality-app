import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path/path.dart' as path;
import '../core/network/dio_client.dart';
import '../core/storage/file_manager.dart';
import '../core/constants/app_constants.dart';
import '../core/exceptions/app_exceptions.dart';
import '../core/utils/app_utils.dart';
import '../data/datasources/remote/media_remote_datasource.dart';
import '../data/datasources/local/media_local_datasource.dart';
import '../data/models/media_file_model.dart';
import '../data/models/document_model.dart';
import '../data/models/service_model.dart';
import '../presentation/providers/database_provider.dart';

final downloadServiceProvider = Provider<DownloadService>((ref) {
  final dioClient = ref.read(dioClientProvider);
  final database = ref.read(appDatabaseProvider);
  final mediaRemoteDataSource = MediaRemoteDataSource(dioClient: dioClient);
  final mediaLocalDataSource = MediaLocalDataSource(database: database);
  
  return DownloadService(
    dioClient: dioClient,
    mediaRemoteDataSource: mediaRemoteDataSource,
    mediaLocalDataSource: mediaLocalDataSource,
  );
});

class DownloadService {
  final DioClient dioClient;
  final MediaRemoteDataSource mediaRemoteDataSource;
  final MediaLocalDataSource mediaLocalDataSource;

  DownloadService({
    required this.dioClient,
    required this.mediaRemoteDataSource,
    required this.mediaLocalDataSource,
  });

  // Download all media files for offline use
  Future<DownloadResult> downloadAllMediaFiles({
    required List<Notice> notices,
    required List<Video> videos,
    required List<Service> services,
    Function(String)? onProgress,
    Function(double)? onProgressPercent,
    Function(String)? onError,
  }) async {
    final List<MediaFileModel> allMediaFiles = [];
    final List<String> downloadedPaths = [];
    final List<String> failedDownloads = [];
    
    try {
      onProgress?.call('Preparing media files for download...');

      // Collect all media files from different sources
      allMediaFiles.addAll(_extractNoticeMediaFiles(notices));
      allMediaFiles.addAll(_extractVideoMediaFiles(videos));
      allMediaFiles.addAll(_extractServiceMediaFiles(services));

      onProgress?.call('Found ${allMediaFiles.length} media files to download');

      if (allMediaFiles.isEmpty) {
        return DownloadResult(
          totalFiles: 0,
          downloadedFiles: 0,
          failedFiles: 0,
          downloadedPaths: [],
          failedDownloads: [],
        );
      }

      // Save media file records to database
      await mediaLocalDataSource.saveMediaFiles(allMediaFiles);

      // Download each file
      for (int i = 0; i < allMediaFiles.length; i++) {
        final mediaFile = allMediaFiles[i];
        final progress = (i / allMediaFiles.length) * 100;
        
        onProgressPercent?.call(progress);
        onProgress?.call('Downloading ${mediaFile.title} (${i + 1}/${allMediaFiles.length})');

        try {
          // Skip if already downloaded
          if (mediaFile.isDownloaded && mediaFile.localPath != null) {
            final file = File(mediaFile.localPath!);
            if (await file.exists()) {
              downloadedPaths.add(mediaFile.localPath!);
              continue;
            }
          }

          final downloadedPath = await _downloadSingleFile(mediaFile);
          
          if (downloadedPath != null) {
            // Update database with local path
            await mediaLocalDataSource.markAsDownloaded(mediaFile.id, downloadedPath);
            downloadedPaths.add(downloadedPath);
            
            onProgress?.call('Downloaded: ${mediaFile.title}');
          } else {
            failedDownloads.add(mediaFile.title);
            onError?.call('Failed to download: ${mediaFile.title}');
          }
        } catch (e) {
          failedDownloads.add(mediaFile.title);
          onError?.call('Error downloading ${mediaFile.title}: $e');
          print('Error downloading ${mediaFile.title}: $e');
        }

        // Small delay to prevent overwhelming the server
        await Future.delayed(const Duration(milliseconds: 100));
      }

      onProgressPercent?.call(100.0);
      onProgress?.call('Download completed');

      return DownloadResult(
        totalFiles: allMediaFiles.length,
        downloadedFiles: downloadedPaths.length,
        failedFiles: failedDownloads.length,
        downloadedPaths: downloadedPaths,
        failedDownloads: failedDownloads,
      );

    } catch (e) {
      onError?.call('Download service error: $e');
      return DownloadResult(
        totalFiles: allMediaFiles.length,
        downloadedFiles: downloadedPaths.length,
        failedFiles: allMediaFiles.length - downloadedPaths.length,
        downloadedPaths: downloadedPaths,
        failedDownloads: failedDownloads,
      );
    }
  }

  // Download single file
  Future<String?> _downloadSingleFile(MediaFileModel mediaFile) async {
    if (mediaFile.url.isEmpty) return null;

    try {
      // Check if file exists on server
      if (!await mediaRemoteDataSource.checkFileExists(mediaFile.url)) {
        return null;
      }

      // Generate unique filename
      final fileName = _generateFileName(mediaFile);
      final folderPath = await _getFolderPath(mediaFile.type);
      final filePath = path.join(folderPath, fileName);

      // Download file
      await mediaRemoteDataSource.downloadFile(
        mediaFile.url,
        filePath,
      );

      // Verify download
      final file = File(filePath);
      if (await file.exists()) {
        return filePath;
      } else {
        return null;
      }
    } catch (e) {
      print('Error downloading file ${mediaFile.title}: $e');
      return null;
    }
  }

  // Extract media files from notices
  List<MediaFileModel> _extractNoticeMediaFiles(List<Notice> notices) {
    final List<MediaFileModel> mediaFiles = [];
    
    for (final notice in notices) {
      // Add image if exists
      if (notice.imageUrl.isNotEmpty) {
        mediaFiles.add(MediaFileModel(
          id: notice.id * 10, // Unique ID for image
          userId: notice.userId,
          title: '${notice.title}_image',
          type: 'image',
          url: notice.imageUrl,
          localPath: null,
          isDownloaded: false,
          createdAt: notice.createdAt,
          updatedAt: notice.updatedAt,
        ));
      }

      // Add file if exists
      if (notice.fileUrl.isNotEmpty) {
        mediaFiles.add(MediaFileModel(
          id: notice.id * 10 + 1, // Unique ID for file
          userId: notice.userId,
          title: '${notice.title}_file',
          type: 'document',
          url: notice.fileUrl,
          localPath: null,
          isDownloaded: false,
          createdAt: notice.createdAt,
          updatedAt: notice.updatedAt,
        ));
      }
    }
    
    return mediaFiles;
  }

  // Extract media files from videos
  List<MediaFileModel> _extractVideoMediaFiles(List<Video> videos) {
    final List<MediaFileModel> mediaFiles = [];
    
    for (final video in videos) {
      if (video.videoUrl.isNotEmpty) {
        mediaFiles.add(MediaFileModel(
          id: video.id * 100, // Unique ID for video
          userId: video.userId,
          title: video.title,
          type: 'video',
          url: video.videoUrl,
          localPath: null,
          isDownloaded: false,
          createdAt: video.createdAt,
          updatedAt: video.updatedAt,
        ));
      }
    }
    
    return mediaFiles;
  }

  // Extract media files from services
  List<MediaFileModel> _extractServiceMediaFiles(List<Service> services) {
    final List<MediaFileModel> mediaFiles = [];
    
    for (final service in services) {
      // Add service video
      if (service.videoUrl.isNotEmpty) {
        mediaFiles.add(MediaFileModel(
          id: service.id * 1000, // Unique ID for service video
          userId: service.userId,
          title: '${service.title}_video',
          type: 'video',
          url: service.videoUrl,
          localPath: null,
          isDownloaded: false,
          createdAt: service.createdAt,
          updatedAt: service.updatedAt,
        ));
      }

      // Add proposal sample file
      if (service.fileUrl.isNotEmpty) {
        mediaFiles.add(MediaFileModel(
          id: service.id * 1000 + 1, // Unique ID for proposal
          userId: service.userId,
          title: '${service.title}_proposal',
          type: 'document',
          url: service.fileUrl,
          localPath: null,
          isDownloaded: false,
          createdAt: service.createdAt,
          updatedAt: service.updatedAt,
        ));
      }

      // Add extra document
      if (service.extraFileUrl.isNotEmpty) {
        mediaFiles.add(MediaFileModel(
          id: service.id * 1000 + 2, // Unique ID for extra doc
          userId: service.userId,
          title: '${service.title}_extra',
          type: 'document',
          url: service.extraFileUrl,
          localPath: null,
          isDownloaded: false,
          createdAt: service.createdAt,
          updatedAt: service.updatedAt,
        ));
      }
    }
    
    return mediaFiles;
  }

  // Generate appropriate filename
  String _generateFileName(MediaFileModel mediaFile) {
    final extension = _getFileExtension(mediaFile.url, mediaFile.type);
    final safeName = AppUtils.sanitizeFileName(mediaFile.title);
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    return '${safeName}_${mediaFile.id}_$timestamp$extension';
  }

  // Get file extension based on URL or type
  String _getFileExtension(String url, String type) {
    // Try to extract extension from URL
    final uri = Uri.tryParse(url);
    if (uri != null) {
      final pathExtension = path.extension(uri.path);
      if (pathExtension.isNotEmpty) {
        return pathExtension;
      }
    }

    // Fallback to type-based extension
    switch (type) {
      case 'image':
        return '.jpg';
      case 'video':
        return '.mp4';
      case 'document':
        return '.pdf';
      default:
        return '.bin';
    }
  }

  // Get appropriate folder path based on media type
  Future<String> _getFolderPath(String type) async {
    switch (type) {
      case 'image':
        return await FileManager.getFolderPath(AppConstants.imagesFolder);
      case 'video':
        return await FileManager.getFolderPath(AppConstants.videosFolder);
      case 'document':
        return await FileManager.getFolderPath(AppConstants.documentsFolder);
      default:
        return await FileManager.getFolderPath(AppConstants.documentsFolder);
    }
  }

  // Get local file path for a media item
  Future<String?> getLocalFilePath(int mediaId) async {
    final mediaFile = await mediaLocalDataSource.getMediaFileById(mediaId);
    if (mediaFile != null && mediaFile.isDownloaded && mediaFile.localPath != null) {
      final file = File(mediaFile.localPath!);
      if (await file.exists()) {
        return mediaFile.localPath;
      }
    }
    return null;
  }

  // Check if file is available locally
  Future<bool> isFileDownloaded(int mediaId) async {
    return await mediaLocalDataSource.isFileDownloaded(mediaId);
  }

  // Get downloaded files by type
  Future<List<MediaFileModel>> getDownloadedFilesByType(String type) async {
    final tables = await mediaLocalDataSource.getDownloadedFilesByType(type);
    return tables.map((table) => _mapTableToModel(table)).toList();
  }

  // Delete local file and update database
  Future<void> deleteLocalFile(int mediaId) async {
    final mediaFile = await mediaLocalDataSource.getMediaFileById(mediaId);
    if (mediaFile != null && mediaFile.localPath != null) {
      final file = File(mediaFile.localPath!);
      if (await file.exists()) {
        await file.delete();
      }
      await mediaLocalDataSource.deleteMediaFile(mediaId);
    }
  }

  // Clear all downloaded files
  Future<void> clearAllDownloads() async {
    // Delete physical files
    await FileManager.clearFolder(AppConstants.imagesFolder);
    await FileManager.clearFolder(AppConstants.videosFolder);
    await FileManager.clearFolder(AppConstants.documentsFolder);
    
    // Clear database records
    await mediaLocalDataSource.clearAllMediaFiles();
  }

  // Get download statistics
  Future<DownloadStats> getDownloadStats() async {
    final totalCount = await mediaLocalDataSource.getTotalDownloadCount();
    final downloadedCount = await mediaLocalDataSource.getDownloadedCount();
    
    return DownloadStats(
      totalFiles: totalCount + downloadedCount,
      downloadedFiles: downloadedCount,
      pendingFiles: totalCount,
    );
  }

  // Map database table to model
  MediaFileModel _mapTableToModel(dynamic table) {
    return MediaFileModel(
      id: table.id,
      userId: table.userId,
      title: table.title,
      type: table.type,
      url: table.url,
      localPath: table.localPath,
      isDownloaded: table.isDownloaded,
      createdAt: table.createdAt,
      updatedAt: table.updatedAt,
    );
  }
}

class DownloadResult {
  final int totalFiles;
  final int downloadedFiles;
  final int failedFiles;
  final List<String> downloadedPaths;
  final List<String> failedDownloads;

  DownloadResult({
    required this.totalFiles,
    required this.downloadedFiles,
    required this.failedFiles,
    required this.downloadedPaths,
    required this.failedDownloads,
  });

  bool get hasFailures => failedFiles > 0;
  bool get isCompleteSuccess => failedFiles == 0 && downloadedFiles == totalFiles;
  double get successRate => totalFiles > 0 ? (downloadedFiles / totalFiles) * 100 : 0;
}

class DownloadStats {
  final int totalFiles;
  final int downloadedFiles;
  final int pendingFiles;

  DownloadStats({
    required this.totalFiles,
    required this.downloadedFiles,
    required this.pendingFiles,
  });

  double get downloadProgress => totalFiles > 0 ? (downloadedFiles / totalFiles) * 100 : 0;
  bool get isComplete => pendingFiles == 0;
}