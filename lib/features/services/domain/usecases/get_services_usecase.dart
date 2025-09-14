import 'package:municipality_app/features/services/domain/entities/service_entity.dart';
import 'package:municipality_app/features/services/domain/repositories/service_repository_interface.dart';

class GetServicesUseCase {
  final ServiceRepositoryInterface repository;

  GetServicesUseCase({required this.repository});

  Future<List<ServiceEntity>> call() async {
    return await repository.getServices();
  }
}