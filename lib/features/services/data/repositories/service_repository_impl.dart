// features/services/data/repositories/service_repository_impl.dart
import 'package:municipality_app/features/services/data/datasources/service_remote_datasource.dart';
import '../../domain/entities/service_entity.dart';
import '../../domain/entities/service_category_entity.dart';
import '../../domain/repositories/service_repository_interface.dart';

class ServiceRepositoryImpl implements ServiceRepositoryInterface {
  final ServiceRemoteDataSource dataSource;

  ServiceRepositoryImpl({required this.dataSource});

  @override
  Future<List<ServiceEntity>> getServices() async {
    final models = await dataSource.getServicesFromApi();
    return models.map((model) => model.toEntity()).toList();
  }

  @override
  Future<List<ServiceCategoryEntity>> getCategories() async {
    final models = await dataSource.getCategoriesFromApi();
    return models.map((model) => model.toEntity()).toList();
  }

  @override
  Future<ServiceEntity?> getServiceById(int id) async {
    final model = await dataSource.getServiceByIdFromApi(id);
    return model?.toEntity();
  }

  @override
  Future<List<ServiceEntity>> getServicesByCategory(String category) async {
    final services = await getServices();
    return services.where((service) => service.category == category).toList();
  }

  @override
  Future<void> cacheServices(List<ServiceEntity> services) async {
    // Implement caching (e.g., using shared_preferences or hive)
    // For now, assume no-op
  }

  @override
  Future<void> clearCache() async {
    // Implement cache clearing
    // For now, assume no-op
  }
}