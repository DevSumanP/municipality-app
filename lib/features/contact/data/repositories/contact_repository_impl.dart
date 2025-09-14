import 'package:municipality_app/features/contact/data/datasource/contact_remote_datasource.dart';
import 'package:municipality_app/features/contact/domain/entities/emergency_contact_entity.dart';
import 'package:municipality_app/features/contact/domain/entities/office_location_entity.dart';
import 'package:municipality_app/features/contact/domain/entities/quick_links_entity.dart';
import 'package:municipality_app/features/contact/domain/repositories/contact_repository.dart';

class ContactRepositoryImpl implements ContactRepositoryInterface {
  final ContactRemoteDatasource dataSource;

  ContactRepositoryImpl({required this.dataSource});

  @override
  Future<List<EmergencyContactEntity>> getEmergencyContacts() async {
    final models = await dataSource.getEmergencyContactsFromApi();
    return models.map((model) => model.toEntity()).toList();
  }

  @override
  Future<List<OfficeLocationEntity>> getOfficeLocations() async {
    final models = await dataSource.getOfficeLocationsFromApi();
    return models.map((model) => model.toEntity()).toList();
  }

  @override
  Future<List<QuickLinkEntity>> getQuickLinks() async{
   final models = await dataSource.getQuickLinksFromApi();
    return models.map((model)=> model.toEntity()).toList();
  }
}
