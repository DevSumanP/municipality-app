import 'package:municipality_app/features/contact/domain/entities/emergency_contact_entity.dart';
import 'package:municipality_app/features/contact/domain/repositories/contact_repository.dart';

class GetEmergencyContactsUsecase {
  final ContactRepositoryInterface repository;

  GetEmergencyContactsUsecase({required this.repository});

  Future<List<EmergencyContactEntity>> call() async{
    return await repository.getEmergencyContacts();
  }
}