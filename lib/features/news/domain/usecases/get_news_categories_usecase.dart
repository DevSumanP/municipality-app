import '../entities/news_category_entity.dart';
import '../repositories/news_repository.dart';

class GetNewsCategoriesUseCase {
  final NewsRepository repository;

  GetNewsCategoriesUseCase(this.repository);

  Future<List<NewsCategoryEntity>> call() async {
    return await repository.getNewsCategories();
  }
}