import '../../../core/database/app_database.dart';
import '../../../core/database/tables/media_files_table.dart';

class MediaLocalDataSource {
  final AppDatabase database;

  MediaLocalDataSource({required this.database});

  Future<List<MediaFilesTable>> getAllMediaFiles() async {
    return await database.mediaFilesDao.getAllMediaFiles();
  }

  Future<MediaFilesTable?> getMediaFileById(int id) async {
    return await database.mediaFilesDao.getMediaFileById(id);
  }

  Future<List<MediaFilesTable>> getMediaFilesByType(String type) async {
    return await database.mediaFilesDao.getMediaFilesByType(type);
  }

  Future<List<MediaFilesTable>> getDownloadedMediaFiles() async {
    return await database.mediaFilesDao.getDownloadedMediaFiles();
  }

  Future<void> saveMediaFile(MediaFilesTable mediaFile) async {
    await database.mediaFilesDao.insertMediaFile(mediaFile);
  }

  Future<void> saveAllMediaFiles(List<MediaFilesTable> mediaFiles) async {
    await database.mediaFilesDao.insertAllMediaFiles(mediaFiles);
  }

  Future<void> updateMediaFile(MediaFilesTable mediaFile) async {
    await database.mediaFilesDao.updateMediaFile(mediaFile);
  }

  Future<void> deleteMediaFile(int id) async {
    await database.mediaFilesDao.deleteMediaFile(id);
  }

  Future<void> deleteAllMediaFiles() async {
    await database.mediaFilesDao.deleteAllMediaFiles();
  }
}