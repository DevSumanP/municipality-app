// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contact_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$contactRemoteDataSourceHash() =>
    r'432e79de16aa56b3ba0cef18b90f1a353567b59b';

/// Remote DataSource Provider
///
/// Copied from [contactRemoteDataSource].
@ProviderFor(contactRemoteDataSource)
final contactRemoteDataSourceProvider =
    AutoDisposeProvider<ContactRemoteDatasource>.internal(
  contactRemoteDataSource,
  name: r'contactRemoteDataSourceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$contactRemoteDataSourceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ContactRemoteDataSourceRef
    = AutoDisposeProviderRef<ContactRemoteDatasource>;
String _$contactRepositoryHash() => r'47dd79b83bb6d8a73d3291b754813f1f33b35bb9';

/// Repository Provider
///
/// Copied from [contactRepository].
@ProviderFor(contactRepository)
final contactRepositoryProvider =
    AutoDisposeProvider<ContactRepositoryInterface>.internal(
  contactRepository,
  name: r'contactRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$contactRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ContactRepositoryRef
    = AutoDisposeProviderRef<ContactRepositoryInterface>;
String _$getEmergencyContactsUsecaseHash() =>
    r'8c2940abf29bc8f2081fe2007ff86b3b6cd3317f';

/// Emergency Contacts UseCase Provider
///
/// Copied from [getEmergencyContactsUsecase].
@ProviderFor(getEmergencyContactsUsecase)
final getEmergencyContactsUsecaseProvider =
    AutoDisposeProvider<GetEmergencyContactsUsecase>.internal(
  getEmergencyContactsUsecase,
  name: r'getEmergencyContactsUsecaseProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$getEmergencyContactsUsecaseHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef GetEmergencyContactsUsecaseRef
    = AutoDisposeProviderRef<GetEmergencyContactsUsecase>;
String _$getOfficeLocationUsecaseHash() =>
    r'fdf449261d7c88502949d397014ddd7aaa71e8c4';

/// Office Location UseCase Provider
///
/// Copied from [getOfficeLocationUsecase].
@ProviderFor(getOfficeLocationUsecase)
final getOfficeLocationUsecaseProvider =
    AutoDisposeProvider<GetOfficeLocationUsecase>.internal(
  getOfficeLocationUsecase,
  name: r'getOfficeLocationUsecaseProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$getOfficeLocationUsecaseHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef GetOfficeLocationUsecaseRef
    = AutoDisposeProviderRef<GetOfficeLocationUsecase>;
String _$getQuickLinkUsecaseHash() =>
    r'3a932648f5dd2539b11cfb8def39377676dc9f66';

/// Quick Link UseCase Provider
///
/// Copied from [getQuickLinkUsecase].
@ProviderFor(getQuickLinkUsecase)
final getQuickLinkUsecaseProvider =
    AutoDisposeProvider<GetQuickLinkUsecase>.internal(
  getQuickLinkUsecase,
  name: r'getQuickLinkUsecaseProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$getQuickLinkUsecaseHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef GetQuickLinkUsecaseRef = AutoDisposeProviderRef<GetQuickLinkUsecase>;
String _$emergencyContactsHash() => r'6002845384efdbf97cbbfbbce094a04eba6aa248';

/// Emergency Contacts Provider
///
/// Copied from [emergencyContacts].
@ProviderFor(emergencyContacts)
final emergencyContactsProvider =
    AutoDisposeProvider<List<EmergencyContactEntity>>.internal(
  emergencyContacts,
  name: r'emergencyContactsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$emergencyContactsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef EmergencyContactsRef
    = AutoDisposeProviderRef<List<EmergencyContactEntity>>;
String _$officeLocationsHash() => r'60683709086c43c9f892fdc513f5930d970aea3b';

/// Office Locations Provider
///
/// Copied from [officeLocations].
@ProviderFor(officeLocations)
final officeLocationsProvider =
    AutoDisposeProvider<List<OfficeLocationEntity>>.internal(
  officeLocations,
  name: r'officeLocationsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$officeLocationsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef OfficeLocationsRef = AutoDisposeProviderRef<List<OfficeLocationEntity>>;
String _$quickLinksHash() => r'6d09ba52c90ce65ac2d77eb8d6f03a6def017c7a';

/// Quick Links Provider
///
/// Copied from [quickLinks].
@ProviderFor(quickLinks)
final quickLinksProvider = AutoDisposeProvider<List<QuickLinkEntity>>.internal(
  quickLinks,
  name: r'quickLinksProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$quickLinksHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef QuickLinksRef = AutoDisposeProviderRef<List<QuickLinkEntity>>;
String _$contactStateNotifierHash() =>
    r'016ca0c7452de6cd1d5fb7ad8013b986ccbe6bf7';

/// Contact State Provider
///
/// Copied from [ContactStateNotifier].
@ProviderFor(ContactStateNotifier)
final contactStateNotifierProvider =
    AutoDisposeNotifierProvider<ContactStateNotifier, ContactState>.internal(
  ContactStateNotifier.new,
  name: r'contactStateNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$contactStateNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$ContactStateNotifier = AutoDisposeNotifier<ContactState>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
