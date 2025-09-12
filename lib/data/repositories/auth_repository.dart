import 'package:dartz/dartz.dart';
import 'package:municipality_app/core/database/app_database.dart';
import '../datasources/remote/auth_remote_datasource.dart';
import '../datasources/local/auth_local_datasource.dart';
import '../models/auth_model.dart';
import '../../core/exceptions/app_exceptions.dart';

class AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final AuthLocalDataSource localDataSource;
  final AppDatabase _db;

  AuthRepository({
    required this.remoteDataSource,
    required this.localDataSource,
    required AppDatabase database,
  }) : _db = database;

  Future<Either<AppException, AuthModel>> login(
      String email, String password) async {
    try {
      final result = await remoteDataSource.login(email, password);
      await localDataSource.saveAuthData(result);
      return Right(result);
    } on AppException catch (e) {
      return Left(e);
    } catch (e) {
      return Left(AppException.unknown(e.toString()));
    }
  }

  Future<Either<AppException, void>> logout() async {
    try {
      await localDataSource.clearAuthData();

      // Clear database data using the SAME singleton instance
      await _db.clearAllData();
      
      print('Access Token after cleanup : ${await getAccessToken()}');
      print('Is logged in after cleanup : ${await isLoggedIn()}');
      print('User after cleanup : ${await getLocalAuthData()}');

      return const Right(null);
    } catch (e) {
      return Left(AppException.unknown(e.toString()));
    }
  }

  Future<Either<AppException, AuthModel?>> getLocalAuthData() async {
    try {
      final result = await localDataSource.getAuthData();
      return Right(result);
    } catch (e) {
      return Left(AppException.unknown(e.toString()));
    }
  }

  Future<Either<AppException, bool>> isLoggedIn() async {
    try {
      final result = await localDataSource.isLoggedIn();
      return Right(result);
    } catch (e) {
      return Left(AppException.unknown(e.toString()));
    }
  }

  Future<Either<AppException, String?>> getAccessToken() async {
    try {
      final result = await localDataSource.getAccessToken();
      return Right(result);
    } catch (e) {
      return Left(AppException.unknown(e.toString()));
    }
  }
}
