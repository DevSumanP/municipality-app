import 'package:municipality_app/features/news/domain/entities/news_article_entity.dart';
import 'package:municipality_app/features/news/domain/repositories/news_repository.dart';

class GetNewsArticlesUseCase {
  final NewsRepository repository;

  GetNewsArticlesUseCase(this.repository);

  Future<List<NewsArticleEntity>> call({
    String? category,
    String? searchQuery,
  }) async {
    return await repository.getNewsArticles(
      category: category,
      searchQuery: searchQuery,
    );
  }
}
