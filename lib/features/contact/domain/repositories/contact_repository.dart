import 'package:municipality_app/features/contact/domain/entities/emergency_contact_entity.dart';
import 'package:municipality_app/features/contact/domain/entities/office_location_entity.dart';
import 'package:municipality_app/features/contact/domain/entities/quick_links_entity.dart';

abstract class ContactRepositoryInterface {
  Future<List<EmergencyContactEntity>> getEmergencyContacts();
  Future<List<OfficeLocationEntity>> getOfficeLocations();
  Future<List<QuickLinkEntity>> getQuickLinks();
}