import 'package:dio/dio.dart';
import 'package:municipality_app/core/constants/api_endpoints.dart';
import 'package:municipality_app/core/exceptions/app_exceptions.dart';
import 'package:municipality_app/core/exceptions/dio_exception.dart';
import 'package:municipality_app/core/network/dio_client.dart';
import 'package:municipality_app/features/contact/data/models/emergency_contact_model.dart';
import 'package:municipality_app/features/contact/data/models/office_location_model.dart';
import 'package:municipality_app/features/contact/data/models/quick_link_model.dart';
import 'package:municipality_app/shared/helpers/handle_list_response.dart';

abstract class ContactRemoteDatasource {
  Future<List<EmergencyContactModel>> getEmergencyContactsFromApi();
  Future<List<OfficeLocationModel>> getOfficeLocationsFromApi();
  Future<List<QuickLinkModel>> getQuickLinksFromApi();
}

class ContactRemoteDatasourceImpl implements ContactRemoteDatasource {
  final DioClient dio;

  ContactRemoteDatasourceImpl({required this.dio});

  @override
  Future<List<EmergencyContactModel>> getEmergencyContactsFromApi() async {
    try {
      final response = await dio.get(ApiEndpoints.emergencyContacts);
      return handleListResponse<EmergencyContactModel>(
        response,
        (json) => EmergencyContactModel.fromJson(json),
        'emergency contacts',
      );
    } on DioException catch (e) {
      throw handleDioError(e);
    } catch (e) {
      if (e is AppException) rethrow;
      throw AppException.unknown('Unexpected error occurred: $e');
    }
  }

  @override
  Future<List<OfficeLocationModel>> getOfficeLocationsFromApi() async {
    try {
      final response = await dio.get(ApiEndpoints.officeLocations);
      return handleListResponse<OfficeLocationModel>(
        response,
        (json) => OfficeLocationModel.fromJson(json),
        'office locations',
      );
    } on DioException catch (e) {
      throw handleDioError(e);
    } catch (e) {
      if (e is AppException) rethrow;
      throw AppException.unknown('Unexpected error occurred: $e');
    }
  }

  @override
  Future<List<QuickLinkModel>> getQuickLinksFromApi() async {
    try {
      final response = await dio.get(ApiEndpoints.quickLinks);
      return handleListResponse<QuickLinkModel>(
        response,
        (json) => QuickLinkModel.fromJson(json),
        'quick links',
      );
    } on DioException catch (e) {
      throw handleDioError(e);
    } catch (e) {
      if (e is AppException) rethrow;
      throw AppException.unknown('Unexpected error occurred: $e');
    }
  }
}
