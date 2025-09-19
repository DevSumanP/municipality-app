import '../entities/department_entity.dart';
import '../repositories/staff_repository_interface.dart';

class GetDepartmentUsecase {
  final StaffRepositoryInterface repository;

  GetDepartmentUsecase({required this.repository});

  Future<List<DepartmentEntity>> call() async {
    return await repository.getDepartments();
  }
}