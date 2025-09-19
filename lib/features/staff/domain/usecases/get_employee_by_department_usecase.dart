import '../entities/employee_entity.dart';
import '../repositories/staff_repository_interface.dart';

class GetEmployeesByDepartmentUsecase {
  final StaffRepositoryInterface repository;

  GetEmployeesByDepartmentUsecase({required this.repository});

  Future<List<EmployeeEntity>> call(String department) async {
    return await repository.getEmployeesByDepartment(department);
  }
}