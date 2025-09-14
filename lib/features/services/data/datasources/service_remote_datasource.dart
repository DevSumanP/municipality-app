// features/services/data/datasources/service_remote_datasource.dart
import 'package:dio/dio.dart';
import '../../../../core/constants/api_endpoints.dart';
import '../../../../core/network/dio_client.dart';
import '../models/service_category_model.dart';
import '../models/service_model.dart';

abstract class ServiceRemoteDataSource {
  Future<List<ServiceModel>> getServicesFromApi();
  Future<List<ServiceCategoryModel>> getCategoriesFromApi();
  Future<ServiceModel?> getServiceByIdFromApi(int id);
}

class ServiceRemoteDataSourceImpl implements ServiceRemoteDataSource {
  final DioClient dio;

  ServiceRemoteDataSourceImpl({required this.dio});

  @override
  Future<List<ServiceModel>> getServicesFromApi() async {
    try {
      final response = await dio
          .get(ApiEndpoints.services); // Use the base Google Sheets API URL

      if (response.statusCode == 200) {
        // The response contains a JSON object with sheet names as keys
        final List<dynamic> servicesJson = response.data as List<dynamic>;
        return servicesJson
            .map((json) => ServiceModel.fromJson(json as Map<String, dynamic>))
            .toList();
      } else {
        throw Exception('Failed to load services: ${response.statusCode}');
      }
    } on DioException catch (e) {
      throw Exception('Dio error: ${e.message}');
    } catch (e) {
      throw Exception('Unexpected error occurred: $e');
    }
  }

  @override
  Future<List<ServiceCategoryModel>> getCategoriesFromApi() async {
    try {
      final response = await dio
          .get(ApiEndpoints.servicesCategories); // Use the base Google Sheets API URL

      if (response.statusCode == 200) {
        // Fetch ServiceCategories from the response
        final List<dynamic> categoriesJson =
            response.data as List<dynamic>;
        return categoriesJson
            .map((json) =>
                ServiceCategoryModel.fromJson(json as Map<String, dynamic>))
            .toList();
      } else {
        throw Exception('Failed to load categories: ${response.statusCode}');
      }
    } on DioException catch (e) {
      throw Exception('Dio error: ${e.message}');
    } catch (e) {
      throw Exception('Unexpected error occurred: $e');
    }
  }

  @override
  Future<ServiceModel?> getServiceByIdFromApi(int id) async {
    try {
      final services = await getServicesFromApi();
      return services.firstWhere(
        (service) => service.id == id,
      );
    } catch (e) {
      return null;
    }
  }
}
