import '../entities/service_category_entity.dart';
import '../repositories/service_repository_interface.dart';

class GetCategoriesUseCase {
  final ServiceRepositoryInterface repository;

  GetCategoriesUseCase({required this.repository});

  Future<List<ServiceCategoryEntity>> call() async {
    return await repository.getCategories();
  }
}