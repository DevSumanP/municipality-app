import 'package:municipality_app/features/contact/domain/entities/office_location_entity.dart';

import '../repositories/contact_repository.dart';

class GetOfficeLocationUsecase {
  final ContactRepositoryInterface repository;

  GetOfficeLocationUsecase({required this.repository});

  Future<List<OfficeLocationEntity>> call() async{
    return await repository.getOfficeLocations();
  }
}