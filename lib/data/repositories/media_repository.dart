import 'package:dartz/dartz.dart';
import 'package:municipality_app/core/database/app_database.dart';
import '../datasources/local/media_local_datasource.dart';
import '../models/media_file_model.dart';
import '../../core/exceptions/app_exceptions.dart';

class MediaRepository {
  final MediaLocalDataSource localDataSource;

  MediaRepository({
    required this.localDataSource,
  });

  Future<Either<AppException, List<MediaFileModel>>> getAllMediaFiles() async {
    try {
      final localMedia = await localDataSource.getAllMediaFiles();
      return Right(localMedia.map((e) => _mapTableToModel(e)).toList());
    } catch (e) {
      return Left(AppException.unknown(e.toString()));
    }
  }

  Future<Either<AppException, List<MediaFileModel>>> getMediaFilesByType(String type) async {
    try {
      final localMedia = await localDataSource.getMediaFilesByType(type);
      return Right(localMedia.map((e) => _mapTableToModel(e)).toList());
    } catch (e) {
      return Left(AppException.unknown(e.toString()));
    }
  }

  Future<Either<AppException, List<MediaFileModel>>> getDownloadedMediaFiles() async {
    try {
      final localMedia = await localDataSource.getDownloadedMediaFiles();
      return Right(localMedia.map((e) => _mapTableToModel(e)).toList());
    } catch (e) {
      return Left(AppException.unknown(e.toString()));
    }
  }

  Future<Either<AppException, void>> saveMediaFile(MediaFileModel mediaFile) async {
    try {
      await localDataSource.saveMediaFile(mediaFile);
      return const Right(null);
    } catch (e) {
      return Left(AppException.unknown(e.toString()));
    }
  }

  Future<Either<AppException, void>> updateMediaFile(MediaFileModel mediaFile) async {
    try {
      await localDataSource.updateMediaFile(mediaFile);
      return const Right(null);
    } catch (e) {
      return Left(AppException.unknown(e.toString()));
    }
  }

  Future<Either<AppException, void>> deleteMediaFile(int id) async {
    try {
      await localDataSource.deleteMediaFile(id);
      return const Right(null);
    } catch (e) {
      return Left(AppException.unknown(e.toString()));
    }
  }

  MediaFileModel _mapTableToModel(MediaFilesTable table) {
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

  MediaFilesTable _mapModelToTable(MediaFileModel model) {
    return MediaFilesTable(
      id: model.id,
      userId: model.userId,
      title: model.title,
      type: model.type,
      url: model.url,
      localPath: model.localPath,
      isDownloaded: model.isDownloaded,
      createdAt: model.createdAt,
      updatedAt: model.updatedAt,
    );
  }
}