import 'package:dartz/dartz.dart';
import '../datasources/remote/auth_remote_datasource.dart';
import '../datasources/local/auth_local_datasource.dart';
import '../models/auth_model.dart';
import '../../core/exceptions/app_exceptions.dart';

class AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final AuthLocalDataSource localDataSource;

  AuthRepository({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  Future<Either<AppException, AuthModel>> login(String email, String password) async {
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