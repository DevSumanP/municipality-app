import '../entities/employee_entity.dart';
import '../repositories/staff_repository_interface.dart';

class GetEmployeeByIdUsecase {
  final StaffRepositoryInterface repository;

  GetEmployeeByIdUsecase({required this.repository});

  Future<EmployeeEntity> call(int id) async {
    return await repository.getEmployeeById(id);
  }
}