import 'package:drift/drift.dart';
import 'package:municipality_app/core/database/app_database.dart';
import 'package:municipality_app/data/models/media_file_model.dart';

class MediaLocalDataSource {
  final AppDatabase database;

  MediaLocalDataSource({required this.database});

  // Save media file record
  Future<void> saveMediaFile(MediaFileModel mediaFile) async {
    await database.into(database.mediaFiles).insertOnConflictUpdate(
      MediaFilesCompanion.insert(
        id: Value(mediaFile.id),
        userId: mediaFile.userId,
        title: mediaFile.title,
        type: mediaFile.type,
        url: mediaFile.url,
        localPath: Value(mediaFile.localPath),
        isDownloaded: Value(mediaFile.isDownloaded),
        createdAt: mediaFile.createdAt,
        updatedAt: mediaFile.updatedAt,
      ),
    );
  }

  // Batch save media files
  Future<void> saveMediaFiles(List<MediaFileModel> mediaFiles) async {
    await database.batch((batch) {
      for (final mediaFile in mediaFiles) {
        batch.insert(
          database.mediaFiles,
          MediaFilesCompanion.insert(
            id: Value(mediaFile.id),
            userId: mediaFile.userId,
            title: mediaFile.title,
            type: mediaFile.type,
            url: mediaFile.url,
            localPath: Value(mediaFile.localPath),
            isDownloaded: Value(mediaFile.isDownloaded),
            createdAt: mediaFile.createdAt,
            updatedAt: mediaFile.updatedAt,
          ),
        );
      }
    });
  }

  // Update media file download status and local path
  Future<void> updateMediaFile(MediaFileModel mediaFile) async {
    await (database.update(database.mediaFiles)
          ..where((tbl) => tbl.id.equals(mediaFile.id)))
        .write(MediaFilesCompanion(
      localPath: Value(mediaFile.localPath),
      isDownloaded: Value(mediaFile.isDownloaded),
      updatedAt: Value(mediaFile.updatedAt),
    ));
  }

  // Mark file as downloaded
  Future<void> markAsDownloaded(int id, String localPath) async {
    await (database.update(database.mediaFiles)
          ..where((tbl) => tbl.id.equals(id)))
        .write(MediaFilesCompanion(
      localPath: Value(localPath),
      isDownloaded: const Value(true),
      updatedAt: Value(DateTime.now().toIso8601String()),
    ));
  }

  // Get all media files
  Future<List<MediaFilesTable>> getAllMediaFiles() async {
    return await database.select(database.mediaFiles).get();
  }

  // Get media files by type (image, video, document)
  Future<List<MediaFilesTable>> getMediaFilesByType(String type) async {
    return await (database.select(database.mediaFiles)
          ..where((tbl) => tbl.type.equals(type)))
        .get();
  }

  // Get downloaded media files
  Future<List<MediaFilesTable>> getDownloadedMediaFiles() async {
    return await (database.select(database.mediaFiles)
          ..where((tbl) => tbl.isDownloaded.equals(true)))
        .get();
  }

  // Get downloaded files by type
  Future<List<MediaFilesTable>> getDownloadedFilesByType(String type) async {
    return await (database.select(database.mediaFiles)
          ..where((tbl) => tbl.type.equals(type) & tbl.isDownloaded.equals(true)))
        .get();
  }

  // Check if file is downloaded
  Future<bool> isFileDownloaded(int id) async {
    final file = await (database.select(database.mediaFiles)
          ..where((tbl) => tbl.id.equals(id)))
        .getSingleOrNull();
    return file?.isDownloaded ?? false;
  }

  // Get media file by ID
  Future<MediaFilesTable?> getMediaFileById(int id) async {
    return await (database.select(database.mediaFiles)
          ..where((tbl) => tbl.id.equals(id)))
        .getSingleOrNull();
  }

  // Delete media file record
  Future<void> deleteMediaFile(int id) async {
    await (database.delete(database.mediaFiles)
          ..where((tbl) => tbl.id.equals(id)))
        .go();
  }

  // Clear all media files
  Future<void> clearAllMediaFiles() async {
    await database.delete(database.mediaFiles).go();
  }

  // Get files that need downloading (not downloaded yet)
  Future<List<MediaFilesTable>> getFilesToDownload() async {
    return await (database.select(database.mediaFiles)
          ..where((tbl) => tbl.isDownloaded.equals(false)))
        .get();
  }

  // Get total download size needed
  Future<int> getTotalDownloadCount() async {
    final result = await database.customSelect(
      'SELECT COUNT(*) as count FROM media_files WHERE is_downloaded = 0',
    ).getSingle();
    return result.data['count'] as int;
  }

  // Get downloaded files count
  Future<int> getDownloadedCount() async {
    final result = await database.customSelect(
      'SELECT COUNT(*) as count FROM media_files WHERE is_downloaded = 1',
    ).getSingle();
    return result.data['count'] as int;
  }

  // Search media files
  Future<List<MediaFilesTable>> searchMediaFiles(String query) async {
    return await (database.select(database.mediaFiles)
          ..where((tbl) => tbl.title.contains(query)))
        .get();
  }

  // Get files by user
  Future<List<MediaFilesTable>> getMediaFilesByUser(String userId) async {
    return await (database.select(database.mediaFiles)
          ..where((tbl) => tbl.userId.equals(userId)))
        .get();
  }
}