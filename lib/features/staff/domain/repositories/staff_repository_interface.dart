
import '../entities/department_entity.dart';
import '../entities/employee_entity.dart';

abstract class StaffRepositoryInterface {
  Future<List<EmployeeEntity>> getEmployees();
  Future<List<DepartmentEntity>> getDepartments();
  Future<EmployeeEntity> getEmployeeById(int id);
  Future<List<EmployeeEntity>> getEmployeesByDepartment(String department);
}
