import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:municipality_app/core/constants/api_endpoints.dart';
import 'package:municipality_app/core/exceptions/dio_exception.dart';
import 'package:municipality_app/core/network/dio_client.dart';
import '../models/announcement_model.dart';
import '../models/news_article_model.dart';
import '../models/news_category_model.dart';

abstract class NewsRemoteDataSource {
  Future<List<NewsArticleModel>> getNewsArticles(
      {String? category, String? searchQuery});
  Future<NewsArticleModel> getNewsArticleById(int id);
  Future<List<AnnouncementModel>> getAnnouncements();
  Future<List<NewsCategoryModel>> getNewsCategories();
  Future<List<NewsArticleModel>> getFeaturedArticles();
}

class NewsRemoteDatasourceImpl implements NewsRemoteDataSource {
  final DioClient dio;
  final Logger logger = Logger();

  NewsRemoteDatasourceImpl({required this.dio});

  @override
  Future<List<NewsArticleModel>> getNewsArticles({
    String? category,
    String? searchQuery,
  }) async {
    try {
      final response = await dio.get(ApiEndpoints.newsArticles);
      logger.d('Raw response [newsArticles]: ${response.data}');
      if (response.statusCode == 200) {
        final List<dynamic> articlesJson = response.data ?? [];
        return articlesJson
            .map((json) => NewsArticleModel.fromJson(json as Map<String, dynamic>))
            .toList();
      } else {
        throw Exception('Failed to load articles: ${response.statusCode}');
      }
    } on DioException catch (e) {
      throw Exception('Dio error: ${e.message}');
    } catch (e) {
      throw Exception('Unexpected error occurred: $e');
    }
  }

  @override
  Future<List<NewsArticleModel>> getFeaturedArticles() async {
    try {
      final response = await dio.get(ApiEndpoints.newsArticles);
      logger.d('Raw response [featuredArticles]: ${response.data}');
      if (response.statusCode == 200) {
        final List<dynamic> featuredJson = response.data ?? [];
        return featuredJson
            .map((json) => NewsArticleModel.fromJson(json as Map<String, dynamic>))
            .toList();
      } else {
        throw Exception('Failed to load featured articles: ${response.statusCode}');
      }
    } on DioException catch (e) {
      throw Exception('Dio error: ${e.message}');
    } catch (e) {
      throw Exception('Unexpected error occurred: $e');
    }
  }

  @override
  Future<List<AnnouncementModel>> getAnnouncements() async {
    try {
      final response = await dio.get(ApiEndpoints.announcement);
      logger.d('Raw response [announcements]: ${response.data}');
      if (response.statusCode == 200) {
        final List<dynamic> announcementsJson = response.data ?? [];
        return announcementsJson
            .map((json) => AnnouncementModel.fromJson(json as Map<String, dynamic>))
            .toList();
      } else {
        throw Exception('Failed to load announcements: ${response.statusCode}');
      }
    } on DioException catch (e) {
      throw Exception('Dio error: ${e.message}');
    } catch (e) {
      throw Exception('Unexpected error occurred: $e');
    }
  }

  @override
  Future<List<NewsCategoryModel>> getNewsCategories() async {
    try {
      final response = await dio.get(ApiEndpoints.newsCategories);
      logger.d('Raw response [newsCategories]: ${response.data}');
      if (response.statusCode == 200) {
        final List<dynamic> categoriesJson = response.data ?? [];
        return categoriesJson
            .map((json) => NewsCategoryModel.fromJson(json as Map<String, dynamic>))
            .toList();
      } else {
        throw Exception('Failed to load categories: ${response.statusCode}');
      }
    } on DioException catch (e) {
      throw Exception('Dio error: ${e.message}');
    } catch (e) {
      throw Exception('Unexpected error occurred: $e');
    }
  }
  
  @override
  Future<NewsArticleModel> getNewsArticleById(int id) {
    // TODO: implement getNewsArticleById
    throw UnimplementedError();
  }
  
}

