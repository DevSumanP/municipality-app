import '../entities/service_entity.dart';
import '../repositories/service_repository_interface.dart';

class GetServiceByIdUseCase {
  final ServiceRepositoryInterface repository;

  GetServiceByIdUseCase({required this.repository});

  Future<ServiceEntity?> call(int id) async {
    return await repository.getServiceById(id);
  }
}