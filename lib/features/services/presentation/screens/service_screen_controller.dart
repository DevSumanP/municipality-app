import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:municipality_app/features/services/data/datasources/service_remote_datasource.dart';
import 'package:municipality_app/features/services/domain/repositories/service_repository_interface.dart';

import '../../../../core/network/dio_client.dart';
import '../../data/repositories/service_repository_impl.dart';
import '../../domain/usecases/get_categories_usecase.dart';
import '../../domain/usecases/get_services_usecase.dart';


// Define ServiceRemoteDataSource provider
final serviceRemoteDataSourceProvider =
    Provider<ServiceRemoteDataSource>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return ServiceRemoteDataSourceImpl(dio: dioClient);
});

// Define ServiceRepositoryInterface provider
final serviceRepositoryProvider = Provider<ServiceRepositoryInterface>((ref) {
  final remoteDataSource = ref.watch(serviceRemoteDataSourceProvider);
  return ServiceRepositoryImpl(dataSource: remoteDataSource);
});

// Define UseCase providers
final getServicesUseCaseProvider = Provider<GetServicesUseCase>((ref) {
  final repository = ref.watch(serviceRepositoryProvider);
  return GetServicesUseCase(repository: repository);
});

final getCategoriesUseCaseProvider = Provider<GetCategoriesUseCase>((ref) {
  final repository = ref.watch(serviceRepositoryProvider);
  return GetCategoriesUseCase(repository: repository);
});
