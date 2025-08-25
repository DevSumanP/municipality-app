import 'package:dio/dio.dart';
import '../../../core/constants/api_endpoints.dart';
import '../../../core/exceptions/app_exceptions.dart';
import '../../../core/network/dio_client.dart';
import '../../models/service_model.dart';

class ServiceRemoteDataSource {
  final DioClient dioClient;

  ServiceRemoteDataSource({required this.dioClient});

  Future<ServiceModel> getServices() async {
    try {
      final response = await dioClient.get(ApiEndpoints.services);

      if (response.statusCode == 200) {
        return ServiceModel.fromJson(response.data);
      } else {
        throw AppException.server('Failed to fetch services');
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        throw AppException.unauthorized('Session expired');
      } else {
        throw AppException.network('Network error occurred');
      }
    } catch (e) {
      throw AppException.unknown('An unknown error occurred');
    }
  }

  Future<ServiceModel> getDepartments() async {
    try {
      final response = await dioClient.get(ApiEndpoints.departments);

      if (response.statusCode == 200) {
        return ServiceModel.fromJson(response.data);
      } else {
        throw AppException.server('Failed to fetch departments');
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        throw AppException.unauthorized('Session expired');
      } else {
        throw AppException.network('Network error occurred');
      }
    } catch (e) {
      throw AppException.unknown('An unknown error occurred');
    }
  }
}