

import '../../domain/entities/department_entity.dart';
import '../../domain/entities/employee_entity.dart';
import '../../domain/repositories/staff_repository_interface.dart';
import '../datasource/staff_remote_datasource.dart';

class StaffRepositoryImpl implements StaffRepositoryInterface {
  final StaffRemoteDatasource dataSource;

  StaffRepositoryImpl({required this.dataSource});

  @override
  Future<List<EmployeeEntity>> getEmployees() async {
    final models = await dataSource.getEmployeesFromApi();
    return models.map((model) => model.toEntity()).toList();
  }

  @override
  Future<List<DepartmentEntity>> getDepartments() async {
    final models = await dataSource.getDepartmentsFromApi();
    return models.map((model) => model.toEntity()).toList();
  }

  @override
  Future<EmployeeEntity> getEmployeeById(int id) async {
    final model = await dataSource.getEmployeeByIdFromApi(id);
    return model.toEntity();
  }

  @override
  Future<List<EmployeeEntity>> getEmployeesByDepartment(String department) async {
    final models = await dataSource.getEmployeesByDepartmentFromApi(department);
    return models.map((model) => model.toEntity()).toList();
  }
}