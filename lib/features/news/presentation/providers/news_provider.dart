import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

import '../../../../core/network/dio_client.dart';
import '../../data/datasources/news_remote_datasource.dart';
import '../../data/repositories/news_repository_impl.dart';
import '../../domain/repositories/news_repository.dart';
import '../../domain/usecases/get_news_articles_by_id_usecase.dart';
import '../../domain/usecases/get_news_articles_usecase.dart';
import '../../domain/usecases/get_announcements_usecase.dart';
import '../../domain/usecases/get_news_categories_usecase.dart';
import '../../domain/usecases/get_featured_articles_usecase.dart';
import '../state/news_state.dart';
import '../../domain/entities/news_article_entity.dart';
import '../../domain/entities/news_category_entity.dart';
import '../../domain/entities/announcement_entity.dart';

import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'news_provider.g.dart';

// Remote datasource
@riverpod
NewsRemoteDataSource newsRemoteDataSource(NewsRemoteDataSourceRef ref) {
  final dio = ref.watch(dioClientProvider);
  return NewsRemoteDatasourceImpl(dio: dio);
}

// Repository
@riverpod
NewsRepository newsRepository(NewsRepositoryRef ref) {
  final remoteDataSource = ref.watch(newsRemoteDataSourceProvider);
  return NewsRepositoryImpl(remoteDataSource: remoteDataSource);
}

// UseCases
@riverpod
GetNewsArticlesUseCase getNewsArticlesUseCase(GetNewsArticlesUseCaseRef ref) {
  final repository = ref.watch(newsRepositoryProvider);
  return GetNewsArticlesUseCase(repository);
}

@riverpod
GetNewsArticleByIdUseCase getNewsArticleByIdUseCase(GetNewsArticleByIdUseCaseRef ref) {
  final repository = ref.watch(newsRepositoryProvider);
  return GetNewsArticleByIdUseCase(repository);
}

@riverpod
GetAnnouncementsUseCase getAnnouncementsUseCase(GetAnnouncementsUseCaseRef ref) {
  final repository = ref.watch(newsRepositoryProvider);
  return GetAnnouncementsUseCase(repository);
}

@riverpod
GetNewsCategoriesUseCase getNewsCategoriesUseCase(GetNewsCategoriesUseCaseRef ref) {
  final repository = ref.watch(newsRepositoryProvider);
  return GetNewsCategoriesUseCase(repository);
}

@riverpod
GetFeaturedArticlesUseCase getFeaturedArticlesUseCase(GetFeaturedArticlesUseCaseRef ref) {
  final repository = ref.watch(newsRepositoryProvider);
  return GetFeaturedArticlesUseCase(repository);
}

// --- StateNotifier ---
class NewsNotifier extends StateNotifier<NewsState> {
  final GetNewsArticlesUseCase getNewsArticlesUseCase;
  final GetAnnouncementsUseCase getAnnouncementsUseCase;
  final GetNewsCategoriesUseCase getNewsCategoriesUseCase;
  final GetFeaturedArticlesUseCase getFeaturedArticlesUseCase;

  NewsNotifier({
    required this.getNewsArticlesUseCase,
    required this.getAnnouncementsUseCase,
    required this.getNewsCategoriesUseCase,
    required this.getFeaturedArticlesUseCase,
  }) : super(const NewsState(isLoading: true)) {
    loadInitialData();
  }

  Future<void> loadInitialData() async {
    state = state.copyWith(isLoading: true, errorMessage: '');
    try {
      final results = await Future.wait([
        getNewsArticlesUseCase(),
        getAnnouncementsUseCase(),
        getNewsCategoriesUseCase(),
        getFeaturedArticlesUseCase(),
      ]);

      state = state.copyWith(
        articles: results[0] as List<NewsArticleEntity>,
        announcements: results[1] as List<AnnouncementEntity>,
        categories: results[2] as List<NewsCategoryEntity>,
        featuredArticles: results[3] as List<NewsArticleEntity>,
        isLoading: false,
      );
    } catch (e) {
      Logger().e('Error loading initial data: $e');
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
    }
  }

  // Update search query without API call - uses local filtering
  void updateSearchQuery(String query) {
    state = state.copyWith(searchQuery: query);
  }

  // Update selected category without API call - uses local filtering
  void updateSelectedCategory(String categoryId) {
    state = state.copyWith(selectedCategory: categoryId);
  }

  // Keep the old methods for backward compatibility (optional)
  Future<void> searchArticles(String query) async {
    updateSearchQuery(query);
  }

  Future<void> filterByCategory(String categoryId) async {
    updateSelectedCategory(categoryId);
  }

  Future<void> refreshData() async => loadInitialData();
}

// --- StateNotifierProvider ---
final newsNotifierProvider = StateNotifierProvider<NewsNotifier, NewsState>((ref) {
  return NewsNotifier(
    getNewsArticlesUseCase: ref.watch(getNewsArticlesUseCaseProvider),
    getAnnouncementsUseCase: ref.watch(getAnnouncementsUseCaseProvider),
    getNewsCategoriesUseCase: ref.watch(getNewsCategoriesUseCaseProvider),
    getFeaturedArticlesUseCase: ref.watch(getFeaturedArticlesUseCaseProvider),
  );
});