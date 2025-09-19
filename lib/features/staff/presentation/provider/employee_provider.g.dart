// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'employee_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$staffRemoteDataSourceHash() =>
    r'926d6bd57fd90150cb961d48c7c97fcfee506fa1';

/// Remote DataSource Provider
///
/// Copied from [staffRemoteDataSource].
@ProviderFor(staffRemoteDataSource)
final staffRemoteDataSourceProvider =
    AutoDisposeProvider<StaffRemoteDatasource>.internal(
  staffRemoteDataSource,
  name: r'staffRemoteDataSourceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$staffRemoteDataSourceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef StaffRemoteDataSourceRef
    = AutoDisposeProviderRef<StaffRemoteDatasource>;
String _$staffRepositoryHash() => r'0194aed1a802c3c2f4be894e5c48780a52ce01c2';

/// Repository Provider
///
/// Copied from [staffRepository].
@ProviderFor(staffRepository)
final staffRepositoryProvider =
    AutoDisposeProvider<StaffRepositoryInterface>.internal(
  staffRepository,
  name: r'staffRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$staffRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef StaffRepositoryRef = AutoDisposeProviderRef<StaffRepositoryInterface>;
String _$getEmployeesUsecaseHash() =>
    r'4eafcd138233c3007480c857fee12d56e90bd2dc';

/// Employees UseCase Provider
///
/// Copied from [getEmployeesUsecase].
@ProviderFor(getEmployeesUsecase)
final getEmployeesUsecaseProvider =
    AutoDisposeProvider<GetEmployeesUsecase>.internal(
  getEmployeesUsecase,
  name: r'getEmployeesUsecaseProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$getEmployeesUsecaseHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef GetEmployeesUsecaseRef = AutoDisposeProviderRef<GetEmployeesUsecase>;
String _$getDepartmentsUsecaseHash() =>
    r'6ffb754746ed115c30e19688cfbab25e9a9c72a4';

/// Departments UseCase Provider
///
/// Copied from [getDepartmentsUsecase].
@ProviderFor(getDepartmentsUsecase)
final getDepartmentsUsecaseProvider =
    AutoDisposeProvider<GetDepartmentUsecase>.internal(
  getDepartmentsUsecase,
  name: r'getDepartmentsUsecaseProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$getDepartmentsUsecaseHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef GetDepartmentsUsecaseRef = AutoDisposeProviderRef<GetDepartmentUsecase>;
String _$getEmployeeByIdUsecaseHash() =>
    r'9a4c0accffcfc973f9b6f730bb7833e0e03aeb7b';

/// Employee By ID UseCase Provider
///
/// Copied from [getEmployeeByIdUsecase].
@ProviderFor(getEmployeeByIdUsecase)
final getEmployeeByIdUsecaseProvider =
    AutoDisposeProvider<GetEmployeeByIdUsecase>.internal(
  getEmployeeByIdUsecase,
  name: r'getEmployeeByIdUsecaseProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$getEmployeeByIdUsecaseHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef GetEmployeeByIdUsecaseRef
    = AutoDisposeProviderRef<GetEmployeeByIdUsecase>;
String _$getEmployeesByDepartmentUsecaseHash() =>
    r'974926dbac1e824c06f358b2d825a66c4e60ab59';

/// Employees By Department UseCase Provider
///
/// Copied from [getEmployeesByDepartmentUsecase].
@ProviderFor(getEmployeesByDepartmentUsecase)
final getEmployeesByDepartmentUsecaseProvider =
    AutoDisposeProvider<GetEmployeesByDepartmentUsecase>.internal(
  getEmployeesByDepartmentUsecase,
  name: r'getEmployeesByDepartmentUsecaseProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$getEmployeesByDepartmentUsecaseHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef GetEmployeesByDepartmentUsecaseRef
    = AutoDisposeProviderRef<GetEmployeesByDepartmentUsecase>;
String _$employeesHash() => r'5b7df26862d86332fbf2f8763cb2af542fb5b58e';

/// Employees Provider
///
/// Copied from [employees].
@ProviderFor(employees)
final employeesProvider = AutoDisposeProvider<List<EmployeeEntity>>.internal(
  employees,
  name: r'employeesProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$employeesHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef EmployeesRef = AutoDisposeProviderRef<List<EmployeeEntity>>;
String _$departmentsHash() => r'0913cd621174fb4b0b40cd0292f5c0501ddea844';

/// Departments Provider
///
/// Copied from [departments].
@ProviderFor(departments)
final departmentsProvider =
    AutoDisposeProvider<List<DepartmentEntity>>.internal(
  departments,
  name: r'departmentsProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$departmentsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef DepartmentsRef = AutoDisposeProviderRef<List<DepartmentEntity>>;
String _$filteredEmployeesHash() => r'29b513d842c05f7e3554a956237698814330ed7b';

/// Filtered Employees Provider
///
/// Copied from [filteredEmployees].
@ProviderFor(filteredEmployees)
final filteredEmployeesProvider =
    AutoDisposeProvider<List<EmployeeEntity>>.internal(
  filteredEmployees,
  name: r'filteredEmployeesProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$filteredEmployeesHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef FilteredEmployeesRef = AutoDisposeProviderRef<List<EmployeeEntity>>;
String _$filteredDepartmentsHash() =>
    r'f07e27965a985d37e9498db9513349110cacc31c';

/// Filtered Departments Provider
///
/// Copied from [filteredDepartments].
@ProviderFor(filteredDepartments)
final filteredDepartmentsProvider =
    AutoDisposeProvider<List<DepartmentEntity>>.internal(
  filteredDepartments,
  name: r'filteredDepartmentsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$filteredDepartmentsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef FilteredDepartmentsRef = AutoDisposeProviderRef<List<DepartmentEntity>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
