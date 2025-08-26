import 'package:dartz/dartz.dart';
import 'package:municipality_app/core/database/app_database.dart';
import 'package:municipality_app/core/exceptions/app_exceptions.dart';
import 'package:municipality_app/data/datasources/remote/service_remote_datasource.dart';
import 'package:municipality_app/data/models/service_model.dart';

import '../datasources/local/service_local_datasource.dart';

class ServiceRepository {
  final ServiceRemoteDataSource remoteDataSource;
  final ServiceLocalDataSource localDataSource;

  ServiceRepository({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  Future<Either<AppException, List<Service>>> getServices() async {
     try {
      //  Try to get local data first
      final localServices = await localDataSource.getAllServices();

      if (localServices.isNotEmpty) {
        return Right(localServices.map((e)=> _mapTableToModel(e)).toList());
      }

      // If no local data, fetch from remote
      final remoteResult = await remoteDataSource.getServices();

      // Save to local database
      await localDataSource.saveServices(remoteResult.data.services);

      return Right(remoteResult.data.services);
     } on AppException catch (e) {
      return Left(e);
    } catch (e) {
      return Left(AppException.unknown(e.toString()));
    }
  }

  Future<Either<AppException, List<Service>>> syncServices() async {
    try {
      final remoteResult = await remoteDataSource.getServices();
      await localDataSource.saveServices(remoteResult.data.services);
      return Right(remoteResult.data.services);
    } on AppException catch (e) {
      return Left(e);
    } catch (e) {
      return Left(AppException.unknown(e.toString()));
    }
  }

  Future<Either<AppException, Service?>> getServiceById(int id) async {
    try {
      final localService = await localDataSource.getServiceById(id);
      if (localService != null) {
        return Right(_mapTableToModel(localService));
      }
      return const Right(null);
    } catch (e) {
      return Left(AppException.unknown(e.toString()));
    }
  }

  Future<Either<AppException, List<Service>>> getServicesByDepartment(int departmentId) async {
    try {
      final localServices = await localDataSource.getServicesByDepartment(departmentId);
      return Right(localServices.map((e) => _mapTableToModel(e)).toList());
    } catch (e) {
      return Left(AppException.unknown(e.toString()));
    }
  }

  Service _mapTableToModel(ServicesTable table) {
    return Service(
      id: table.id,
      userId: table.userId,
      departmentId: table.departmentId,
      title: table.title,
      description: table.description,
      proposalSample: table.proposalSample,
      video: table.video,
      extraDocument: table.extraDocument,
      status: table.status,
      order: table.order,
      createdAt: table.createdAt,
      updatedAt: table.updatedAt,
      isUpdated: table.isUpdated,
      videoUrl: table.videoUrl ?? '',
      fileUrl: table.fileUrl ?? '',
      extraFileUrl: table.extraFileUrl ?? '',
      responsiblePeople: [], // Will be populated separately if needed
      department: null, // Will be populated separately if needed
    );
  }
}