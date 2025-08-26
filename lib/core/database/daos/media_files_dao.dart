import 'package:drift/drift.dart';
import '../app_database.dart';
import '../tables/media_files_table.dart';

part 'media_files_dao.g.dart';

@DriftAccessor(tables: [MediaFiles])
class MediaFilesDao extends DatabaseAccessor<AppDatabase> with _$MediaFilesDaoMixin {
  MediaFilesDao(AppDatabase db) : super(db);

  // Get all media files
  Future<List<MediaFilesTable>> getAllMediaFiles() async {
    return await (select(mediaFiles)
      ..orderBy([(tbl) => OrderingTerm(expression: tbl.createdAt, mode: OrderingMode.desc)])
    ).get();
  }

  // Get media file by ID
  Future<MediaFilesTable?> getMediaFileById(int id) async {
    return await (select(mediaFiles)..where((tbl) => tbl.id.equals(id))).getSingleOrNull();
  }

  // Get media files by type
  Future<List<MediaFilesTable>> getMediaFilesByType(String type) async {
    return await (select(mediaFiles)
      ..where((tbl) => tbl.type.equals(type))
      ..orderBy([(tbl) => OrderingTerm(expression: tbl.createdAt, mode: OrderingMode.desc)])
    ).get();
  }

  // Get downloaded media files
  Future<List<MediaFilesTable>> getDownloadedMediaFiles() async {
    return await (select(mediaFiles)
      ..where((tbl) => tbl.isDownloaded.equals(true))
      ..orderBy([(tbl) => OrderingTerm(expression: tbl.createdAt, mode: OrderingMode.desc)])
    ).get();
  }

  // Get media files count
  Future<int> getMediaFilesCount() async {
    final query = selectOnly(mediaFiles)..addColumns([mediaFiles.id.count()]);
    final result = await query.getSingle();
    return result.read(mediaFiles.id.count()) ?? 0;
  }

  // Get media files count by type
  Future<int> getMediaFilesCountByType(String type) async {
    final query = selectOnly(mediaFiles)
      ..addColumns([mediaFiles.id.count()])
      ..where(mediaFiles.type.equals(type));
    final result = await query.getSingle();
    return result.read(mediaFiles.id.count()) ?? 0;
  }

  // Get downloaded media files count
  Future<int> getDownloadedMediaFilesCount() async {
    final query = selectOnly(mediaFiles)
      ..addColumns([mediaFiles.id.count()])
      ..where(mediaFiles.isDownloaded.equals(true));
    final result = await query.getSingle();
    return result.read(mediaFiles.id.count()) ?? 0;
  }

  // Insert single media file
  Future<int> insertMediaFile(MediaFilesTable mediaFile) async {
    return await into(mediaFiles).insert(mediaFile, mode: InsertMode.insertOrReplace);
  }

  // Insert multiple media files
  Future<void> insertAllMediaFiles(List<MediaFilesTable> mediaFilesList) async {
    await batch((batch) {
      batch.insertAllOnConflictUpdate(mediaFiles, mediaFilesList);
    });
  }

  // Update media file
  Future<bool> updateMediaFile(MediaFilesTable mediaFile) async {
    return await update(mediaFiles).replace(mediaFile);
  }

  // Update download status
  Future<int> updateDownloadStatus(int id, bool isDownloaded, String? localPath) async {
    return await (update(mediaFiles)..where((tbl) => tbl.id.equals(id)))
        .write(MediaFilesCompanion(
          isDownloaded: Value(isDownloaded),
          localPath: Value(localPath),
        ));
  }

  // Delete media file
  Future<int> deleteMediaFile(int id) async {
    return await (delete(mediaFiles)..where((tbl) => tbl.id.equals(id))).go();
  }

  // Delete media files by type
  Future<int> deleteMediaFilesByType(String type) async {
    return await (delete(mediaFiles)..where((tbl) => tbl.type.equals(type))).go();
  }

  // Delete all media files
  Future<int> deleteAllMediaFiles() async {
    return await delete(mediaFiles).go();
  }

  // Search media files
  Future<List<MediaFilesTable>> searchMediaFiles(String query) async {
    return await (select(mediaFiles)
      ..where((tbl) => tbl.title.contains(query))
      ..orderBy([(tbl) => OrderingTerm(expression: tbl.createdAt, mode: OrderingMode.desc)])
    ).get();
  }

  // Get media files by user
  Future<List<MediaFilesTable>> getMediaFilesByUser(String userId) async {
    return await (select(mediaFiles)
      ..where((tbl) => tbl.userId.equals(userId))
      ..orderBy([(tbl) => OrderingTerm(expression: tbl.createdAt, mode: OrderingMode.desc)])
    ).get();
  }

  // Get recent media files
  Future<List<MediaFilesTable>> getRecentMediaFiles({int limit = 10}) async {
    return await (select(mediaFiles)
      ..orderBy([(tbl) => OrderingTerm(expression: tbl.createdAt, mode: OrderingMode.desc)])
      ..limit(limit)
    ).get();
  }

  // Get media files by local path
  Future<MediaFilesTable?> getMediaFileByLocalPath(String localPath) async {
    return await (select(mediaFiles)..where((tbl) => tbl.localPath.equals(localPath))).getSingleOrNull();
  }

  // Get media files by URL
  Future<MediaFilesTable?> getMediaFileByUrl(String url) async {
    return await (select(mediaFiles)..where((tbl) => tbl.url.equals(url))).getSingleOrNull();
  }

  // Clean up orphaned media files (files marked as downloaded but local file doesn't exist)
  Future<List<MediaFilesTable>> getOrphanedMediaFiles() async {
    return await (select(mediaFiles)
      ..where((tbl) => tbl.isDownloaded.equals(true) & tbl.localPath.isNotNull())
    ).get();
  }

  // Get total storage size used by downloaded media
  Future<double> getTotalStorageSize() async {
    // This would need to be implemented by checking actual file sizes
    // Returns 0.0 for now as a placeholder
    return 0.0;
  }
}