import 'package:municipality_app/features/news/data/datasources/news_remote_datasource.dart';
import 'package:municipality_app/features/news/domain/entities/announcement_entity.dart';

import 'package:municipality_app/features/news/domain/entities/news_article_entity.dart';

import 'package:municipality_app/features/news/domain/entities/news_category_entity.dart';

import '../../domain/repositories/news_repository.dart';

class NewsRepositoryImpl implements NewsRepository {
  final NewsRemoteDataSource remoteDataSource;

  NewsRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<NewsArticleEntity>> getNewsArticles({
    String? category,
    String? searchQuery,
  }) async {
    try {
      final articles = await remoteDataSource.getNewsArticles(
        category: category,
        searchQuery: searchQuery,
      );
      return articles.map((model) => model.toEntity()).toList();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<NewsArticleEntity> getNewsArticleById(int id) async {
    try {
      final article = await remoteDataSource.getNewsArticleById(id);
      return article.toEntity();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<AnnouncementEntity>> getAnnouncements() async {
    try {
      final announcements = await remoteDataSource.getAnnouncements();
      return announcements.map((model) => model.toEntity()).toList();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<NewsCategoryEntity>> getNewsCategories() async {
    try {
      final categories = await remoteDataSource.getNewsCategories();
      return categories.map((model) => model.toEntity()).toList();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<NewsArticleEntity>> getFeaturedArticles() async {
    try {
      final articles = await remoteDataSource.getFeaturedArticles();
      return articles.map((model) => model.toEntity()).toList();
    } catch (e) {
      rethrow;
    }
  }
}
