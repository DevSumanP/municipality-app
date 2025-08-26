import 'package:dartz/dartz.dart';
import 'package:municipality_app/core/database/app_database.dart';
import '../datasources/remote/document_remote_datasource.dart';
import '../datasources/local/document_local_datasource.dart';
import '../models/document_model.dart';
import '../../core/exceptions/app_exceptions.dart';

class DocumentRepository {
  final DocumentRemoteDataSource remoteDataSource;
  final DocumentLocalDataSource localDataSource;

  DocumentRepository({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  Future<Either<AppException, List<Notice>>> getNotices() async {
    try {
      // Try to get local data first
      final localNotices = await localDataSource.getDocumentsByType('notice');
      
      if (localNotices.isNotEmpty) {
        return Right(localNotices.map((e) => _mapTableToNotice(e)).toList());
      }

      // If no local data, fetch from remote
      final remoteResult = await remoteDataSource.getNotices();
      
      // Save to local database
      await localDataSource.saveNotices(remoteResult.data.notices ?? []);
      
      return Right(remoteResult.data.notices ?? []);
    } on AppException catch (e) {
      return Left(e);
    } catch (e) {
      return Left(AppException.unknown(e.toString()));
    }
  }

  Future<Either<AppException, List<ScrollingNews>>> getScrollingNews() async {
    try {
      // Try to get local data first
      final localNews = await localDataSource.getDocumentsByType('scrolling_news');
      
      if (localNews.isNotEmpty) {
        return Right(localNews.map((e) => _mapTableToScrollingNews(e)).toList());
      }

      // If no local data, fetch from remote
      final remoteResult = await remoteDataSource.getScrollingNews();
      
      // Save to local database
      await localDataSource.saveScrollingNews(remoteResult.data.scrollingNews ?? []);
      
      return Right(remoteResult.data.scrollingNews ?? []);
    } on AppException catch (e) {
      return Left(e);
    } catch (e) {
      return Left(AppException.unknown(e.toString()));
    }
  }

  Future<Either<AppException, List<Video>>> getVideos() async {
    try {
      final remoteResult = await remoteDataSource.getVideos();
      return Right(remoteResult.data.videos ?? []);
    } on AppException catch (e) {
      return Left(e);
    } catch (e) {
      return Left(AppException.unknown(e.toString()));
    }
  }

  Future<Either<AppException, void>> syncNotices() async {
    try {
      final remoteResult = await remoteDataSource.getNotices();
      await localDataSource.saveNotices(remoteResult.data.notices ?? []);
      return const Right(null);
    } on AppException catch (e) {
      return Left(e);
    } catch (e) {
      return Left(AppException.unknown(e.toString()));
    }
  }

  Future<Either<AppException, void>> syncScrollingNews() async {
    try {
      final remoteResult = await remoteDataSource.getScrollingNews();
      await localDataSource.saveScrollingNews(remoteResult.data.scrollingNews ?? []);
      return const Right(null);
    } on AppException catch (e) {
      return Left(e);
    } catch (e) {
      return Left(AppException.unknown(e.toString()));
    }
  }

  Notice _mapTableToNotice(DocumentsTable table) {   // or DocumentsData depending on generated name
  return Notice(
    id: table.id,
    userId: table.userId,
    title: table.title,
    description: table.description,
    image: table.imageUrl,
    file: table.fileUrl,
    status: table.status,
    createdAt: table.createdAt,
    updatedAt: table.updatedAt,
    isUpdated: table.isUpdated,
    imageUrl: table.imageUrl ?? '',
    fileUrl: table.fileUrl ?? '',
  );
}

ScrollingNews _mapTableToScrollingNews(DocumentsTable table) {  // same here
  return ScrollingNews(
    id: table.id,
    userId: table.userId,
    title: table.title,
    status: table.status,
    createdAt: table.createdAt,
    updatedAt: table.updatedAt,
  );
}

}