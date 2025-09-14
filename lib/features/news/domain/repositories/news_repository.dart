import 'package:municipality_app/features/news/domain/entities/news_article_entity.dart';

import '../entities/announcement_entity.dart';
import '../entities/news_category_entity.dart';

abstract class NewsRepository {
  Future<List<NewsArticleEntity>> getNewsArticles(
      {String? category, String? searchQuery});
  Future<NewsArticleEntity> getNewsArticleById(int id);

  Future<List<AnnouncementEntity>> getAnnouncements();

  Future<List<NewsCategoryEntity>> getNewsCategories();

  Future<List<NewsArticleEntity>> getFeaturedArticles();
}
