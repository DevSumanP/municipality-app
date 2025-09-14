
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:municipality_app/core/network/dio_client.dart';
import 'package:municipality_app/features/contact/data/datasource/contact_remote_datasource.dart';
import 'package:municipality_app/features/contact/data/repositories/contact_repository_impl.dart';
import 'package:municipality_app/features/contact/domain/repositories/contact_repository.dart';
import 'package:municipality_app/features/contact/domain/entities/emergency_contact_entity.dart';
import 'package:municipality_app/features/contact/domain/entities/office_location_entity.dart';
import 'package:municipality_app/features/contact/domain/usecases/get_emergency_contacts_usecase.dart';
import 'package:municipality_app/features/contact/domain/usecases/get_office_location_usecase.dart';
import 'package:municipality_app/features/contact/domain/usecases/get_quick_link_usecase.dart';
import 'package:municipality_app/core/exceptions/app_exceptions.dart';

import '../../domain/entities/quick_links_entity.dart';
import '../state/contact_state.dart';

part 'contact_provider.g.dart';

// ========== DATA LAYER PROVIDERS ==========

/// Remote DataSource Provider
@riverpod
ContactRemoteDatasource contactRemoteDataSource(ContactRemoteDataSourceRef ref) {
  final dio = ref.watch(dioClientProvider);
  return ContactRemoteDatasourceImpl(dio: dio);
}

/// Repository Provider
@riverpod
ContactRepositoryInterface contactRepository(ContactRepositoryRef ref) {
  final remoteDataSource = ref.watch(contactRemoteDataSourceProvider);
  return ContactRepositoryImpl(dataSource: remoteDataSource);
}

// ========== DOMAIN LAYER PROVIDERS ==========

/// Emergency Contacts UseCase Provider
@riverpod
GetEmergencyContactsUsecase getEmergencyContactsUsecase(GetEmergencyContactsUsecaseRef ref) {
  final repository = ref.watch(contactRepositoryProvider);
  return GetEmergencyContactsUsecase(repository: repository);
}

/// Office Location UseCase Provider
@riverpod
GetOfficeLocationUsecase getOfficeLocationUsecase(GetOfficeLocationUsecaseRef ref) {
  final repository = ref.watch(contactRepositoryProvider);
  return GetOfficeLocationUsecase(repository: repository);
}

/// Quick Link UseCase Provider
@riverpod
GetQuickLinkUsecase getQuickLinkUsecase(GetQuickLinkUsecaseRef ref) {
  final repository = ref.watch(contactRepositoryProvider);
  return GetQuickLinkUsecase(repository: repository);
}

/// Contact State Notifier
class ContactNotifier extends StateNotifier<ContactState> {
  final GetEmergencyContactsUsecase _getEmergencyContactsUsecase;
  final GetOfficeLocationUsecase _getOfficeLocationUsecase;
  final GetQuickLinkUsecase _getQuickLinkUsecase;

  ContactNotifier({
    required GetEmergencyContactsUsecase getEmergencyContactsUsecase,
    required GetOfficeLocationUsecase getOfficeLocationUsecase,
    required GetQuickLinkUsecase getQuickLinkUsecase,
  })  : _getEmergencyContactsUsecase = getEmergencyContactsUsecase,
        _getOfficeLocationUsecase = getOfficeLocationUsecase,
        _getQuickLinkUsecase = getQuickLinkUsecase,
        super(const ContactState()) {
    loadInitialData();
  }

  /// Load all initial data
  Future<void> loadInitialData() async {
    state = state.copyWith(isLoading: true);
    
    try {
      // Load all data concurrently
      final results = await Future.wait([
        _getEmergencyContactsUsecase(),
        _getOfficeLocationUsecase(),
        _getQuickLinkUsecase(),
      ]);

      state = state.copyWith(
        isLoading: false,
        emergencyContacts: results[0] as List<EmergencyContactEntity>,
        officeLocations: results[1] as List<OfficeLocationEntity>,
        quickLinks: results[2] as List<QuickLinkEntity>,
      );
    } on AppException catch (e) {
      state = state.copyWith(
        isLoading: false,
        exception: e,
        errorMessage: e.message,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'An unexpected error occurred: $e',
      );
    }
  }

  /// Refresh all data
  Future<void> refreshData() async {
    await loadInitialData();
  }

  /// Load emergency contacts only
  Future<void> loadEmergencyContacts() async {
    state = state.copyWith(isLoading: true);
    
    try {
      final contacts = await _getEmergencyContactsUsecase();
      state = state.copyWith(
        isLoading: false,
        emergencyContacts: contacts,
      );
    } on AppException catch (e) {
      state = state.copyWith(
        isLoading: false,
        exception: e,
        errorMessage: e.message,
      );
    }
  }

  /// Load office locations only
  Future<void> loadOfficeLocations() async {
    state = state.copyWith(isLoading: true);
    
    try {
      final locations = await _getOfficeLocationUsecase();
      state = state.copyWith(
        isLoading: false,
        officeLocations: locations,
      );
    } on AppException catch (e) {
      state = state.copyWith(
        isLoading: false,
        exception: e,
        errorMessage: e.message,
      );
    }
  }

  /// Load quick links only
  Future<void> loadQuickLinks() async {
    state = state.copyWith(isLoading: true);
    
    try {
      final links = await _getQuickLinkUsecase();
      state = state.copyWith(
        isLoading: false,
        quickLinks: links,
      );
    } on AppException catch (e) {
      state = state.copyWith(
        isLoading: false,
        exception: e,
        errorMessage: e.message,
      );
    }
  }

  /// Clear error state
  void clearError() {
    state = state.clearError();
  }
}

// ========== STATE NOTIFIER PROVIDER ==========

/// Contact State Provider
@riverpod
class ContactStateNotifier extends _$ContactStateNotifier {
  @override
  ContactState build() {
    final getEmergencyContactsUsecase = ref.watch(getEmergencyContactsUsecaseProvider);
    final getOfficeLocationUsecase = ref.watch(getOfficeLocationUsecaseProvider);
    final getQuickLinkUsecase = ref.watch(getQuickLinkUsecaseProvider);

    return ContactState();
  }

  /// Get the notifier instance
  ContactNotifier get notifier => ContactNotifier(
        getEmergencyContactsUsecase: ref.read(getEmergencyContactsUsecaseProvider),
        getOfficeLocationUsecase: ref.read(getOfficeLocationUsecaseProvider),
        getQuickLinkUsecase: ref.read(getQuickLinkUsecaseProvider),
      );
}

// Alternative: Traditional StateNotifierProvider (choose one approach)
final contactStateProvider = StateNotifierProvider<ContactNotifier, ContactState>((ref) {
  final getEmergencyContactsUsecase = ref.watch(getEmergencyContactsUsecaseProvider);
  final getOfficeLocationUsecase = ref.watch(getOfficeLocationUsecaseProvider);
  final getQuickLinkUsecase = ref.watch(getQuickLinkUsecaseProvider);

  return ContactNotifier(
    getEmergencyContactsUsecase: getEmergencyContactsUsecase,
    getOfficeLocationUsecase: getOfficeLocationUsecase,
    getQuickLinkUsecase: getQuickLinkUsecase,
  );
});

// ========== CONVENIENCE PROVIDERS ==========

/// Emergency Contacts Provider
@riverpod
List<EmergencyContactEntity> emergencyContacts(EmergencyContactsRef ref) {
  return ref.watch(contactStateProvider.select((state) => state.emergencyContacts));
}

/// Office Locations Provider
@riverpod
List<OfficeLocationEntity> officeLocations(OfficeLocationsRef ref) {
  return ref.watch(contactStateProvider.select((state) => state.officeLocations));
}

/// Quick Links Provider
@riverpod
List<QuickLinkEntity> quickLinks(QuickLinksRef ref) {
  return ref.watch(contactStateProvider.select((state) => state.quickLinks));
}