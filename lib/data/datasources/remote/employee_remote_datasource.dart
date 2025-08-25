import 'package:dio/dio.dart';
import '../../../core/network/dio_client.dart';
import '../../../core/constants/api_endpoints.dart';
import '../../../core/exceptions/app_exceptions.dart';
import '../../models/employee_model.dart';

class EmployeeRemoteDataSource {
  final DioClient dioClient;

  EmployeeRemoteDataSource({required this.dioClient});

  Future<EmployeeModel> getEmployees() async {
    try {
      final response = await dioClient.get(ApiEndpoints.employees);

      if (response.statusCode == 200) {
        return EmployeeModel.fromJson(response.data);
      } else {
        throw AppException.server('Failed to fetch employees');
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