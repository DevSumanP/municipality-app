import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/news_article_entity.dart';
import '../../domain/entities/announcement_entity.dart';
import '../../domain/entities/news_category_entity.dart';

part 'news_state.freezed.dart';

@freezed
class NewsState with _$NewsState {
  const NewsState._(); 

  const factory NewsState({
    @Default([]) List<NewsArticleEntity> articles,
    @Default([]) List<AnnouncementEntity> announcements,
    @Default([]) List<NewsCategoryEntity> categories,
    @Default([]) List<NewsArticleEntity> featuredArticles,
    @Default(false) bool isLoading,
    @Default(false) bool isLoadingMore,
    @Default('') String errorMessage,
    @Default('all') String selectedCategory,
    @Default('') String searchQuery,
  }) = _NewsState;

  // Add computed getter for filtered articles
  List<NewsArticleEntity> get filteredArticles {
    return articles.where((article) {
      final matchesSearch = searchQuery.isEmpty ||
          article.title.toLowerCase().contains(searchQuery.toLowerCase()) ||
          article.excerpt.toLowerCase().contains(searchQuery.toLowerCase());
      final matchesCategory = selectedCategory == 'all' ||
          article.category == selectedCategory;
      return matchesSearch && matchesCategory && !article.featured;
    }).toList();
  }

  // Add computed getter for featured article
  NewsArticleEntity? get featuredArticle {
    try {
      return articles.firstWhere((article) => article.featured);
    } catch (e) {
      return null;
    }
  }
}

@freezed
class ArticleDetailState with _$ArticleDetailState {
  const factory ArticleDetailState({
    NewsArticleEntity? article,
    @Default(false) bool isLoading,
    @Default('') String errorMessage,
  }) = _ArticleDetailState;
}