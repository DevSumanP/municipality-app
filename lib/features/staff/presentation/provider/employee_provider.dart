import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:municipality_app/core/network/dio_client.dart';

import '../../../../core/exceptions/app_exceptions.dart';
import '../../data/datasource/staff_remote_datasource.dart';
import '../../data/repositories/staff_repository_impl.dart';
import '../../domain/entities/department_entity.dart';
import '../../domain/entities/employee_entity.dart';
import '../../domain/repositories/staff_repository_interface.dart';

import '../../domain/usecases/get_departments_usecase.dart';
import '../../domain/usecases/get_employee_by_department_usecase.dart';
import '../../domain/usecases/get_employee_by_id.dart';
import '../../domain/usecases/get_employees_usecase.dart';
import '../state/employee_state.dart';

part 'employee_provider.g.dart';

// ========== DATA LAYER PROVIDERS ==========

/// Remote DataSource Provider
@riverpod
StaffRemoteDatasource staffRemoteDataSource(StaffRemoteDataSourceRef ref) {
  final dio = ref.watch(dioClientProvider);
  return StaffRemoteDatasourceImpl(dio: dio);
}

/// Repository Provider
@riverpod
StaffRepositoryInterface staffRepository(StaffRepositoryRef ref) {
  final remoteDataSource = ref.watch(staffRemoteDataSourceProvider);
  return StaffRepositoryImpl(dataSource: remoteDataSource);
}

// ========== DOMAIN LAYER PROVIDERS ==========

/// Employees UseCase Provider
@riverpod
GetEmployeesUsecase getEmployeesUsecase(GetEmployeesUsecaseRef ref) {
  final repository = ref.watch(staffRepositoryProvider);
  return GetEmployeesUsecase(repository: repository);
}

/// Departments UseCase Provider
@riverpod
GetDepartmentUsecase getDepartmentsUsecase(GetDepartmentsUsecaseRef ref) {
  final repository = ref.watch(staffRepositoryProvider);
  return GetDepartmentUsecase(repository: repository);
}

/// Employee By ID UseCase Provider
@riverpod
GetEmployeeByIdUsecase getEmployeeByIdUsecase(GetEmployeeByIdUsecaseRef ref) {
  final repository = ref.watch(staffRepositoryProvider);
  return GetEmployeeByIdUsecase(repository: repository);
}

/// Employees By Department UseCase Provider
@riverpod
GetEmployeesByDepartmentUsecase getEmployeesByDepartmentUsecase(GetEmployeesByDepartmentUsecaseRef ref) {
  final repository = ref.watch(staffRepositoryProvider);
  return GetEmployeesByDepartmentUsecase(repository: repository);
}

/// Staff State Notifier
class StaffNotifier extends StateNotifier<StaffState> {
  final GetEmployeesUsecase _getEmployeesUsecase;
  final GetDepartmentUsecase _getDepartmentsUsecase;
  final GetEmployeeByIdUsecase _getEmployeeByIdUsecase;
  final GetEmployeesByDepartmentUsecase _getEmployeesByDepartmentUsecase;

  StaffNotifier({
    required GetEmployeesUsecase getEmployeesUsecase,
    required GetDepartmentUsecase getDepartmentsUsecase,
    required GetEmployeeByIdUsecase getEmployeeByIdUsecase,
    required GetEmployeesByDepartmentUsecase getEmployeesByDepartmentUsecase,
  })  : _getEmployeesUsecase = getEmployeesUsecase,
        _getDepartmentsUsecase = getDepartmentsUsecase,
        _getEmployeeByIdUsecase = getEmployeeByIdUsecase,
        _getEmployeesByDepartmentUsecase = getEmployeesByDepartmentUsecase,
        super(const StaffState()) {
    loadInitialData();
  }

  /// Load all initial data
  Future<void> loadInitialData() async {
    state = state.copyWith(isLoading: true);
    
    try {
      // Load all data concurrently
      final results = await Future.wait([
        _getEmployeesUsecase(),
        _getDepartmentsUsecase(),
      ]);

      state = state.copyWith(
        isLoading: false,
        employees: results[0] as List<EmployeeEntity>,
        departments: results[1] as List<DepartmentEntity>,
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

  /// Load employees only
  Future<void> loadEmployees() async {
    state = state.copyWith(isLoading: true);
    
    try {
      final employees = await _getEmployeesUsecase();
      state = state.copyWith(
        isLoading: false,
        employees: employees,
      );
    } on AppException catch (e) {
      state = state.copyWith(
        isLoading: false,
        exception: e,
        errorMessage: e.message,
      );
    }
  }

  /// Load departments only
  Future<void> loadDepartments() async {
    state = state.copyWith(isLoading: true);
    
    try {
      final departments = await _getDepartmentsUsecase();
      state = state.copyWith(
        isLoading: false,
        departments: departments,
      );
    } on AppException catch (e) {
      state = state.copyWith(
        isLoading: false,
        exception: e,
        errorMessage: e.message,
      );
    }
  }

  /// Load employee by ID
  Future<void> loadEmployeeById(int id) async {
    try {
      final employee = await _getEmployeeByIdUsecase(id);
      state = state.copyWith(selectedEmployee: employee);
    } on AppException catch (e) {
      state = state.copyWith(
        exception: e,
        errorMessage: e.message,
      );
    }
  }

  /// Load employees by department
  Future<void> loadEmployeesByDepartment(String department) async {
    state = state.copyWith(isLoading: true);
    
    try {
      final employees = await _getEmployeesByDepartmentUsecase(department);
      state = state.copyWith(
        isLoading: false,
        employees: employees,
      );
    } on AppException catch (e) {
      state = state.copyWith(
        isLoading: false,
        exception: e,
        errorMessage: e.message,
      );
    }
  }

  /// Update search query
  void updateSearchQuery(String query) {
    state = state.copyWith(searchQuery: query);
  }

  /// Update selected department
  void updateSelectedDepartment(String department) {
    state = state.copyWith(selectedDepartment: department);
  }

  /// Update selected view
  void updateSelectedView(String view) {
    state = state.copyWith(selectedView: view);
  }

  /// Clear error state
  void clearError() {
    state = state.clearError();
  }

  /// Clear selected employee
  void clearSelectedEmployee() {
    state = state.clearSelectedEmployee();
  }
}

// ========== STATE NOTIFIER PROVIDER ==========

/// Staff State Provider
final staffStateProvider = StateNotifierProvider<StaffNotifier, StaffState>((ref) {
  final getEmployeesUsecase = ref.watch(getEmployeesUsecaseProvider);
  final getDepartmentsUsecase = ref.watch(getDepartmentsUsecaseProvider);
  final getEmployeeByIdUsecase = ref.watch(getEmployeeByIdUsecaseProvider);
  final getEmployeesByDepartmentUsecase = ref.watch(getEmployeesByDepartmentUsecaseProvider);

  return StaffNotifier(
    getEmployeesUsecase: getEmployeesUsecase,
    getDepartmentsUsecase: getDepartmentsUsecase,
    getEmployeeByIdUsecase: getEmployeeByIdUsecase,
    getEmployeesByDepartmentUsecase: getEmployeesByDepartmentUsecase,
  );
});

// ========== CONVENIENCE PROVIDERS ==========

/// Employees Provider
@riverpod
List<EmployeeEntity> employees(EmployeesRef ref) {
  return ref.watch(staffStateProvider.select((state) => state.employees));
}

/// Departments Provider
@riverpod
List<DepartmentEntity> departments(DepartmentsRef ref) {
  return ref.watch(staffStateProvider.select((state) => state.departments));
}

/// Filtered Employees Provider
@riverpod
List<EmployeeEntity> filteredEmployees(FilteredEmployeesRef ref) {
  return ref.watch(staffStateProvider.select((state) => state.filteredEmployees));
}

/// Filtered Departments Provider
@riverpod
List<DepartmentEntity> filteredDepartments(FilteredDepartmentsRef ref) {
  return ref.watch(staffStateProvider.select((state) => state.filteredDepartments));
}