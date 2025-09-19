import 'package:municipality_app/features/staff/domain/entities/employee_entity.dart';
import '../repositories/staff_repository_interface.dart';

class GetEmployeesUsecase {
  final StaffRepositoryInterface repository;

  GetEmployeesUsecase({required this.repository});

  Future<List<EmployeeEntity>> call() async {
    return await repository.getEmployees();
  }
}