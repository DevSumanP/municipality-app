import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:municipality_app/presentation/providers/database_provider.dart';
import '../../data/datasources/local/employee_local_datasource.dart';
import '../../data/repositories/employee_repository.dart';
import '../../data/datasources/remote/employee_remote_datasource.dart';
import '../../data/models/employee_model.dart';
import '../../core/network/dio_client.dart';

// Employee repository provider
final employeeRepositoryProvider = Provider<EmployeeRepository>((ref) {
  final dioClient = ref.read(dioClientProvider);
  final database = ref.watch(appDatabaseProvider);
  
  return EmployeeRepository(
    remoteDataSource: EmployeeRemoteDataSource(dioClient: dioClient),
    localDataSource: EmployeeLocalDataSource(database: database),
  );
});

// Employees state
class EmployeesState {
  final bool isLoading;
  final List<Employee> employees;
  final List<Designation> designations;
  final List<Category> categories;
  final List<Department> departments;
  final String? error;
  final bool hasData;

  const EmployeesState({
    this.isLoading = false,
    this.employees = const [],
    this.designations = const [],
    this.categories = const [],
    this.departments = const [],
    this.error,
    this.hasData = false,
  });

  EmployeesState copyWith({
    bool? isLoading,
    List<Employee>? employees,
    List<Designation>? designations,
    List<Category>? categories,
    List<Department>? departments,
    String? error,
    bool? hasData,
  }) {
    return EmployeesState(
      isLoading: isLoading ?? this.isLoading,
      employees: employees ?? this.employees,
      designations: designations ?? this.designations,
      categories: categories ?? this.categories,
      departments: departments ?? this.departments,
      error: error,
      hasData: hasData ?? this.hasData,
    );
  }

  bool get hasError => error != null;
  bool get isEmpty => employees.isEmpty;
  int get employeesCount => employees.length;
}

// Employees notifier
class EmployeesNotifier extends StateNotifier<EmployeesState> {
  final EmployeeRepository _employeeRepository;

  EmployeesNotifier(this._employeeRepository) : super(const EmployeesState()) {
    loadEmployees();
  }

  Future<void> loadEmployees({bool forceRefresh = false}) async {
    if (state.isLoading) return;

    if (!forceRefresh && state.hasData) return;

    state = state.copyWith(isLoading: true, error: null);

    try {
      final result = await _employeeRepository.getEmployees();
      
      result.fold(
        (error) {
          state = state.copyWith(
            isLoading: false,
            error: error.message,
          );
        },
        (employeeData) {
          state = state.copyWith(
            isLoading: false,
            employees: employeeData.employees,
            designations: employeeData.designations,
            categories: employeeData.categories,
            departments: employeeData.departments,
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

  Future<void> syncEmployees() async {
    if (state.isLoading) return;

    state = state.copyWith(isLoading: true, error: null);

    try {
      final result = await _employeeRepository.syncEmployees();
      
      result.fold(
        (error) {
          state = state.copyWith(
            isLoading: false,
            error: error.message,
          );
        },
        (employeeData) {
          state = state.copyWith(
            isLoading: false,
            employees: employeeData.employees,
            designations: employeeData.designations,
            categories: employeeData.categories,
            departments: employeeData.departments,
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

  Future<Employee?> getEmployeeById(int id) async {
    // First check in current state
    try {
      return state.employees.firstWhere((employee) => employee.id == id);
    } catch (e) {
      // If not found in state, try repository
      final result = await _employeeRepository.getEmployeeById(id);
      return result.fold(
        (error) => null,
        (employee) => employee,
      );
    }
  }

  List<Employee> getEmployeesByDepartment(int departmentId) {
    return state.employees
        .where((employee) => employee.departmentId == departmentId)
        .toList();
  }

  List<Employee> getEmployeesByDesignation(String designationId) {
    return state.employees
        .where((employee) => employee.designationId == designationId)
        .toList();
  }

  List<Employee> getEmployeesByCategory(String categoryId) {
    return state.employees
        .where((employee) => employee.categoryId == categoryId)
        .toList();
  }

  List<Employee> searchEmployees(String query) {
    if (query.isEmpty) return state.employees;
    
    final lowerQuery = query.toLowerCase();
    return state.employees.where((employee) {
      return employee.name.toLowerCase().contains(lowerQuery) ||
             employee.designation.title.toLowerCase().contains(lowerQuery) ||
             (employee.email?.toLowerCase().contains(lowerQuery) ?? false) ||
             (employee.phone?.contains(query) ?? false);
    }).toList();
  }

  Designation? getDesignationById(String id) {
    try {
      return state.designations.firstWhere((designation) => designation.id.toString() == id);
    } catch (e) {
      return null;
    }
  }

  Category? getCategoryById(String id) {
    try {
      return state.categories.firstWhere((category) => category.id.toString() == id);
    } catch (e) {
      return null;
    }
  }

  Department? getDepartmentById(int id) {
    try {
      return state.departments.firstWhere((department) => department.id == id);
    } catch (e) {
      return null;
    }
  }

  void clearError() {
    if (state.error != null) {
      state = state.copyWith(error: null);
    }
  }

  void refresh() {
    loadEmployees(forceRefresh: true);
  }
}

// Employees provider
final employeesProvider = StateNotifierProvider<EmployeesNotifier, EmployeesState>((ref) {
  final employeeRepository = ref.read(employeeRepositoryProvider);
  return EmployeesNotifier(employeeRepository);
});

// Convenience providers
final employeesLoadingProvider = Provider<bool>((ref) {
  return ref.watch(employeesProvider).isLoading;
});

final employeesErrorProvider = Provider<String?>((ref) {
  return ref.watch(employeesProvider).error;
});

final employeesListProvider = Provider<List<Employee>>((ref) {
  return ref.watch(employeesProvider).employees;
});

final designationsListProvider = Provider<List<Designation>>((ref) {
  return ref.watch(employeesProvider).designations;
});

final categoriesListProvider = Provider<List<Category>>((ref) {
  return ref.watch(employeesProvider).categories;
});

final departmentsListProvider = Provider<List<Department>>((ref) {
  return ref.watch(employeesProvider).departments;
});

final employeesCountProvider = Provider<int>((ref) {
  return ref.watch(employeesProvider).employeesCount;
});

// Employee by ID provider
final employeeByIdProvider = Provider.family<Employee?, int>((ref, id) {
  final employees = ref.watch(employeesListProvider);
  try {
    return employees.firstWhere((employee) => employee.id == id);
  } catch (e) {
    return null;
  }
});

// Employees by department provider
final employeesByDepartmentProvider = Provider.family<List<Employee>, int?>((ref, departmentId) {
  final employees = ref.watch(employeesListProvider);
  if (departmentId == null) return employees;
  
  return employees.where((employee) => employee.departmentId == departmentId).toList();
});

// Search employees provider
final searchEmployeesProvider = Provider.family<List<Employee>, String>((ref, query) {
  final employees = ref.watch(employeesListProvider);
  if (query.isEmpty) return employees;
  
  final lowerQuery = query.toLowerCase();
  return employees.where((employee) {
    return employee.name.toLowerCase().contains(lowerQuery) ||
           employee.designation.title.toLowerCase().contains(lowerQuery) ||
           (employee.email?.toLowerCase().contains(lowerQuery) ?? false) ||
           (employee.phone?.contains(query) ?? false);
  }).toList();
});