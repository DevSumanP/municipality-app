import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:equatable/equatable.dart';
import '../../domain/entities/service_entity.dart';
import '../../domain/entities/service_category_entity.dart';
import '../../domain/usecases/get_services_usecase.dart';
import '../../domain/usecases/get_categories_usecase.dart';
import '../../domain/usecases/filter_service_usecase.dart';
import '../screens/service_screen_controller.dart';

class ServiceState extends Equatable {
  final List<ServiceEntity> services;
  final List<ServiceCategoryEntity> categories;
  final String searchQuery;
  final String selectedCategory;
  final bool isLoading;
  final String? error;

  const ServiceState({
    this.services = const [],
    this.categories = const [],
    this.searchQuery = '',
    this.selectedCategory = 'all',
    this.isLoading = false,
    this.error = '',
  });

  ServiceState copyWith({
    List<ServiceEntity>? services,
    List<ServiceCategoryEntity>? categories,
    String? searchQuery,
    String? selectedCategory,
    bool? isLoading,
    String? error,
  }) {
    return ServiceState(
      services: services ?? this.services,
      categories: categories ?? this.categories,
      searchQuery: searchQuery ?? this.searchQuery,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }

  List<ServiceEntity> get filteredServices => FilterServiceUsecase()(
        services: services,
        searchQuery: searchQuery,
        selectedCategory: selectedCategory,
      );

  @override
  List<Object?> get props =>
      [services, categories, searchQuery, selectedCategory, isLoading, error];
}

class ServiceNotifier extends StateNotifier<ServiceState> {
  final GetServicesUseCase getServicesUseCase;
  final GetCategoriesUseCase getCategoriesUseCase;

  ServiceNotifier(this.getServicesUseCase, this.getCategoriesUseCase)
      : super(ServiceState(isLoading: true)) {
    loadInitialData();
  }

  Future<void> loadInitialData() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final results = await Future.wait([
        getServicesUseCase(),
        getCategoriesUseCase(),
      ]);
      state = state.copyWith(
        services: results[0] as List<ServiceEntity>,
        categories: results[1] as List<ServiceCategoryEntity>,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(error: e.toString(), isLoading: false);
    }
  }

  Future<void> refreshData() async => loadInitialData();

  void updateSearchQuery(String query) {
    state = state.copyWith(searchQuery: query);
  }

  void updateSelectedCategory(String categoryId) {
    state = state.copyWith(selectedCategory: categoryId);
  }
}

final serviceProvider =
    StateNotifierProvider<ServiceNotifier, ServiceState>((ref) {
  final getServicesUseCase = ref.watch(getServicesUseCaseProvider);
  final getCategoriesUseCase = ref.watch(getCategoriesUseCaseProvider);
  return ServiceNotifier(getServicesUseCase, getCategoriesUseCase);
});
