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
      print('[EmployeeRemoteDataSource] Fetching employees from: ${ApiEndpoints.employees}');
      final response = await dioClient.get(ApiEndpoints.employees);
      print('[EmployeeRemoteDataSource] Response status: ${response.statusCode}');

      if (response.statusCode == 200) {
        try {
          final jsonData = response.data;
          print('[EmployeeRemoteDataSource] Response data type: ${jsonData.runtimeType}');
          
          if (jsonData is! Map<String, dynamic>) {
            throw const FormatException('Invalid response format: Expected JSON object');
          }
          
          if (jsonData['data'] == null) {
            print('[EmployeeRemoteDataSource] Missing data field in response');
            throw const FormatException('Missing data field in response');
          }
          
          final employeeModel = EmployeeModel.fromJson(jsonData);
          print('[EmployeeRemoteDataSource] Successfully parsed ${employeeModel.data.employees.length} employees');
          return employeeModel;
        } catch (e, stackTrace) {
          print('[EmployeeRemoteDataSource] Error parsing employee data: $e');
          print('Stack trace: $stackTrace');
          rethrow;
        }
      } else {
        final errorMsg = 'Failed to fetch employees. Status: ${response.statusCode}';
        print('[EmployeeRemoteDataSource] $errorMsg');
        throw AppException.server(errorMsg);
      }
    } on DioException catch (e) {
      final errorMsg = 'Network error: ${e.message}';
      print('[EmployeeRemoteDataSource] $errorMsg');
      if (e.response?.statusCode == 401) {
        throw AppException.unauthorized('Session expired');
      } else {
        throw AppException.network(errorMsg);
      }
    } catch (e, stackTrace) {
      print('[EmployeeRemoteDataSource] Unexpected error: $e');
      print('Stack trace: $stackTrace');
      throw AppException.unknown('An error occurred while fetching employees: $e');
    }
  }
}