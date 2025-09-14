import '../../../../core/exceptions/app_exceptions.dart';
import '../../domain/entities/emergency_contact_entity.dart';
import '../../domain/entities/office_location_entity.dart';
import '../../domain/entities/quick_links_entity.dart';

/// Contact State class using freezed or manual implementation
class ContactState {
  final bool isLoading;
  final List<EmergencyContactEntity> emergencyContacts;
  final List<OfficeLocationEntity> officeLocations;
  final List<QuickLinkEntity> quickLinks;
  final String? errorMessage;
  final AppException? exception;

  const ContactState({
    this.isLoading = false,
    this.emergencyContacts = const [],
    this.officeLocations = const [],
    this.quickLinks = const [],
    this.errorMessage,
    this.exception,
  });

  /// Copy with method for immutable updates
  ContactState copyWith({
    bool? isLoading,
    List<EmergencyContactEntity>? emergencyContacts,
    List<OfficeLocationEntity>? officeLocations,
    List<QuickLinkEntity>? quickLinks,
    String? errorMessage,
    AppException? exception,
  }) {
    return ContactState(
      isLoading: isLoading ?? this.isLoading,
      emergencyContacts: emergencyContacts ?? this.emergencyContacts,
      officeLocations: officeLocations ?? this.officeLocations,
      quickLinks: quickLinks ?? this.quickLinks,
      errorMessage: errorMessage ?? this.errorMessage,
      exception: exception ?? this.exception,
    );
  }

  /// Clear error state
  ContactState clearError() {
    return copyWith(
      errorMessage: null,
      exception: null,
    );
  }

  /// Check if all data is loaded
  bool get hasData => 
      emergencyContacts.isNotEmpty && 
      officeLocations.isNotEmpty && 
      quickLinks.isNotEmpty;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ContactState &&
          runtimeType == other.runtimeType &&
          isLoading == other.isLoading &&
          emergencyContacts == other.emergencyContacts &&
          officeLocations == other.officeLocations &&
          quickLinks == other.quickLinks &&
          errorMessage == other.errorMessage;

  @override
  int get hashCode =>
      isLoading.hashCode ^
      emergencyContacts.hashCode ^
      officeLocations.hashCode ^
      quickLinks.hashCode ^
      errorMessage.hashCode;
}
