import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:municipality_app/core/exceptions/app_exceptions.dart';
import '../../domain/entities/department_entity.dart';
import '../../domain/entities/employee_entity.dart';

part 'employee_state.freezed.dart';

/// Staff State class for managing employees and departments using Freezed
@freezed
class StaffState with _$StaffState {
  const factory StaffState({
    @Default(false) bool isLoading,
    @Default([]) List<EmployeeEntity> employees,
    @Default([]) List<DepartmentEntity> departments,
    EmployeeEntity? selectedEmployee,
    @Default('') String searchQuery,
    @Default('all') String selectedDepartment,
    @Default('departments') String selectedView, // 'departments' or 'employees'
    String? errorMessage,
    AppException? exception,
  }) = _StaffState;

  const StaffState._();

  /// Get filtered employees based on search query and selected department
  List<EmployeeEntity> get filteredEmployees {
    return employees.where((employee) {
      final matchesSearch = searchQuery.isEmpty ||
          employee.name.toLowerCase().contains(searchQuery.toLowerCase()) ||
          employee.title.toLowerCase().contains(searchQuery.toLowerCase()) ||
          employee.department.toLowerCase().contains(searchQuery.toLowerCase());
      
      final matchesDepartment = selectedDepartment == 'all' || 
          employee.department == selectedDepartment;
      
      return matchesSearch && matchesDepartment;
    }).toList();
  }

  /// Get filtered departments based on search query
  List<DepartmentEntity> get filteredDepartments {
    return departments.where((department) =>
        searchQuery.isEmpty ||
        department.name.toLowerCase().contains(searchQuery.toLowerCase()) ||
        department.description.toLowerCase().contains(searchQuery.toLowerCase())
    ).toList();
  }

  /// Check if all data is loaded
  bool get hasData => employees.isNotEmpty && departments.isNotEmpty;

  /// Clear error state
  StaffState clearError() {
    return copyWith(
      errorMessage: null,
      exception: null,
    );
  }

  /// Clear selected employee
  StaffState clearSelectedEmployee() {
    return copyWith(
      selectedEmployee: null,
    );
  }
}