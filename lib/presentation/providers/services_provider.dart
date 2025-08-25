import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:municipality_app/data/datasources/local/service_local_datasource.dart';
import '../../data/repositories/service_repository.dart';
import '../../data/datasources/remote/service_remote_datasource.dart';
import '../../data/models/service_model.dart';
import '../../core/network/dio_client.dart';
import 'database_provider.dart';

// Service repository provider
final serviceRepositoryProvider = Provider<ServiceRepository>((ref) {
  final dioClient = ref.read(dioClientProvider);
  final database = ref.watch(appDatabaseProvider);
  
  return ServiceRepository(
    remoteDataSource: ServiceRemoteDataSource(dioClient: dioClient),
    localDataSource: ServiceLocalDataSource(database: database),
  );
});

// Services state
class ServicesState {
  final bool isLoading;
  final List<Service> services;
  final String? error;
  final bool hasData;

  const ServicesState({
    this.isLoading = false,
    this.services = const [],
    this.error,
    this.hasData = false,
  });

  ServicesState copyWith({
    bool? isLoading,
    List<Service>? services,
    String? error,
    bool? hasData,
  }) {
    return ServicesState(
      isLoading: isLoading ?? this.isLoading,
      services: services ?? this.services,
      error: error,
      hasData: hasData ?? this.hasData,
    );
  }

  bool get hasError => error != null;
  bool get isEmpty => services.isEmpty;
  int get servicesCount => services.length;
}

// Services notifier
class ServicesNotifier extends StateNotifier<ServicesState> {
  final ServiceRepository _serviceRepository;

  ServicesNotifier(this._serviceRepository) : super(const ServicesState()) {
    loadServices();
  }

  Future<void> loadServices({bool forceRefresh = false}) async {
    if (state.isLoading) return;

    if (!forceRefresh && state.hasData) return;

    state = state.copyWith(isLoading: true, error: null);

    try {
      final result = await _serviceRepository.getServices();
      
      result.fold(
        (error) {
          state = state.copyWith(
            isLoading: false,
            error: error.message,
          );
        },
        (services) {
          state = state.copyWith(
            isLoading: false,
            services: services,
            hasData: true,
            error: null,
          );
        },
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  Future<void> syncServices() async {
    if (state.isLoading) return;

    state = state.copyWith(isLoading: true, error: null);

    try {
      final result = await _serviceRepository.syncServices();
      
      result.fold(
        (error) {
          state = state.copyWith(
            isLoading: false,
            error: error.message,
          );
        },
        (services) {
          state = state.copyWith(
            isLoading: false,
            services: services,
            hasData: true,
            error: null,
          );
        },
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  Future<Service?> getServiceById(int id) async {
    // First check in current state
    try {
      return state.services.firstWhere((service) => service.id == id);
    } catch (e) {
      // If not found in state, try repository
      final result = await _serviceRepository.getServiceById(id);
      return result.fold(
        (error) => null,
        (service) => service,
      );
    }
  }

  List<Service> getServicesByDepartment(int departmentId) {
    return state.services
        .where((service) => service.departmentId == departmentId)
        .toList();
  }

  List<Service> searchServices(String query) {
    if (query.isEmpty) return state.services;
    
    final lowerQuery = query.toLowerCase();
    return state.services.where((service) {
      return service.title.toLowerCase().contains(lowerQuery) ||
             service.description.toLowerCase().contains(lowerQuery);
    }).toList();
  }

  void clearError() {
    if (state.error != null) {
      state = state.copyWith(error: null);
    }
  }

  void refresh() {
    loadServices(forceRefresh: true);
  }
}

// Services provider
final servicesProvider = StateNotifierProvider<ServicesNotifier, ServicesState>((ref) {
  final serviceRepository = ref.read(serviceRepositoryProvider);
  return ServicesNotifier(serviceRepository);
});

// Convenience providers
final servicesLoadingProvider = Provider<bool>((ref) {
  return ref.watch(servicesProvider).isLoading;
});

final servicesErrorProvider = Provider<String?>((ref) {
  return ref.watch(servicesProvider).error;
});

final servicesListProvider = Provider<List<Service>>((ref) {
  return ref.watch(servicesProvider).services;
});

final servicesCountProvider = Provider<int>((ref) {
  return ref.watch(servicesProvider).servicesCount;
});

// Service by ID provider
final serviceByIdProvider = Provider.family<Service?, int>((ref, id) {
  final services = ref.watch(servicesListProvider);
  try {
    return services.firstWhere((service) => service.id == id);
  } catch (e) {
    return null;
  }
});

// Services by department provider
final servicesByDepartmentProvider = Provider.family<List<Service>, int?>((ref, departmentId) {
  final services = ref.watch(servicesListProvider);
  if (departmentId == null) return services;
  
  return services.where((service) => service.departmentId == departmentId).toList();
});

// Search services provider
final searchServicesProvider = Provider.family<List<Service>, String>((ref, query) {
  final services = ref.watch(servicesListProvider);
  if (query.isEmpty) return services;
  
  final lowerQuery = query.toLowerCase();
  return services.where((service) {
    return service.title.toLowerCase().contains(lowerQuery) ||
           service.description.toLowerCase().contains(lowerQuery);
  }).toList();
});