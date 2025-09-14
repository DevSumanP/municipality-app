import '../entities/news_article_entity.dart';
import '../repositories/news_repository.dart';

class GetNewsArticleByIdUseCase {
  final NewsRepository repository;

  GetNewsArticleByIdUseCase(this.repository);

  Future<NewsArticleEntity> call(int id) async {
    return await repository.getNewsArticleById(id);
  }
}
