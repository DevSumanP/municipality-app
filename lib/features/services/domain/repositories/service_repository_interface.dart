import 'package:municipality_app/features/services/domain/entities/service_category_entity.dart';
import 'package:municipality_app/features/services/domain/entities/service_entity.dart';

abstract class ServiceRepositoryInterface {
  Future<List<ServiceEntity>> getServices();
  Future<List<ServiceCategoryEntity>> getCategories();
  Future<ServiceEntity?> getServiceById(int id);
  Future<List<ServiceEntity>> getServicesByCategory(String category);
  Future<void> cacheServices(List<ServiceEntity> services);
  Future<void> clearCache();
}
