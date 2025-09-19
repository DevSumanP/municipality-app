import 'package:dio/dio.dart';
import 'package:municipality_app/core/constants/api_endpoints.dart';
import 'package:municipality_app/core/exceptions/app_exceptions.dart';
import 'package:municipality_app/core/exceptions/dio_exception.dart';
import 'package:municipality_app/core/network/dio_client.dart';
import 'package:municipality_app/features/staff/data/models/employee_model.dart';
import 'package:municipality_app/features/staff/data/models/department_model.dart';
import 'package:municipality_app/shared/helpers/handle_list_response.dart';

abstract class StaffRemoteDatasource {
  Future<List<EmployeeModel>> getEmployeesFromApi();
  Future<List<DepartmentModel>> getDepartmentsFromApi();
  Future<EmployeeModel> getEmployeeByIdFromApi(int id);
  Future<List<EmployeeModel>> getEmployeesByDepartmentFromApi(String department);
}

class StaffRemoteDatasourceImpl implements StaffRemoteDatasource {
  final DioClient dio;

  StaffRemoteDatasourceImpl({required this.dio});

  @override
  Future<List<EmployeeModel>> getEmployeesFromApi() async {
    try {
      final response = await dio.get(ApiEndpoints.employees);
      return handleListResponse<EmployeeModel>(
        response,
        (json) => EmployeeModel.fromJson(json),
        'employees',
      );
    } on DioException catch (e) {
      throw handleDioError(e);
    } catch (e) {
      if (e is AppException) rethrow;
      throw AppException.unknown('Unexpected error occurred: $e');
    }
  }

  @override
  Future<List<DepartmentModel>> getDepartmentsFromApi() async {
    try {
      final response = await dio.get(ApiEndpoints.departments);
      return handleListResponse<DepartmentModel>(
        response,
        (json) => DepartmentModel.fromJson(json),
        'departments',
      );
    } on DioException catch (e) {
      throw handleDioError(e);
    } catch (e) {
      if (e is AppException) rethrow;
      throw AppException.unknown('Unexpected error occurred: $e');
    }
  }

  @override
  Future<EmployeeModel> getEmployeeByIdFromApi(int id) async {
    try {
      final response = await dio.get('${ApiEndpoints.employees}/$id');
      if (response.data != null) {
        return EmployeeModel.fromJson(response.data);
      } else {
        throw AppException.unknown('Employee not found');
      }
    } on DioException catch (e) {
      throw handleDioError(e);
    } catch (e) {
      if (e is AppException) rethrow;
      throw AppException.unknown('Unexpected error occurred: $e');
    }
  }

  @override
  Future<List<EmployeeModel>> getEmployeesByDepartmentFromApi(String department) async {
    try {
      final response = await dio.get(
        ApiEndpoints.employees,
        queryParameters: {'department': department},
      );
      return handleListResponse<EmployeeModel>(
        response,
        (json) => EmployeeModel.fromJson(json),
        'employees',
      );
    } on DioException catch (e) {
      throw handleDioError(e);
    } catch (e) {
      if (e is AppException) rethrow;
      throw AppException.unknown('Unexpected error occurred: $e');
    }
  }
}