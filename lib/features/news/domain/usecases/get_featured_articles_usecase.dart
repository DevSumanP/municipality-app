import '../entities/news_article_entity.dart';
import '../repositories/news_repository.dart';

class GetFeaturedArticlesUseCase {
  final NewsRepository repository;

  GetFeaturedArticlesUseCase(this.repository);

  Future<List<NewsArticleEntity>> call() async {
    return await repository.getFeaturedArticles();
  }
}