import 'package:dartz/dartz.dart';
import '../datasources/remote/employee_remote_datasource.dart';
import '../datasources/local/employee_local_datasource.dart';
import '../models/employee_model.dart';
import '../../core/database/tables/employees_table.dart';
import '../../core/exceptions/app_exceptions.dart';

class EmployeeRepository {
  final EmployeeRemoteDataSource remoteDataSource;
  final EmployeeLocalDataSource localDataSource;

  EmployeeRepository({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  Future<Either<AppException, EmployeeData>> getEmployees() async {
    try {
      // Try to get local data first
      final localEmployees = await localDataSource.getAllEmployees();
      
      if (localEmployees.isNotEmpty) {
        // Convert to EmployeeData format
        final employees = localEmployees.map((e) => _mapTableToModel(e)).toList();
        return Right(EmployeeData(
          employees: employees,
          designations: [],
          categories: [],
          departments: [],
        ));
      }

      // If no local data, fetch from remote
      final remoteResult = await remoteDataSource.getEmployees();
      
      // Save to local database
      await localDataSource.saveEmployees(remoteResult.data.employees);
      
      return Right(remoteResult.data);
    } on AppException catch (e) {
      return Left(e);
    } catch (e) {
      return Left(AppException.unknown(e.toString()));
    }
  }

  Future<Either<AppException, EmployeeData>> syncEmployees() async {
    try {
      final remoteResult = await remoteDataSource.getEmployees();
      await localDataSource.saveEmployees(remoteResult.data.employees);
      return Right(remoteResult.data);
    } on AppException catch (e) {
      return Left(e);
    } catch (e) {
      return Left(AppException.unknown(e.toString()));
    }
  }

  Future<Either<AppException, Employee?>> getEmployeeById(int id) async {
    try {
      final localEmployee = await localDataSource.getEmployeeById(id);
      if (localEmployee != null) {
        return Right(_mapTableToModel(localEmployee));
      }
      return const Right(null);
    } catch (e) {
      return Left(AppException.unknown(e.toString()));
    }
  }

  Future<Either<AppException, List<Employee>>> getEmployeesByDepartment(int departmentId) async {
    try {
      final localEmployees = await localDataSource.getEmployeesByDepartment(departmentId);
      return Right(localEmployees.map((e) => _mapTableToModel(e)).toList());
    } catch (e) {
      return Left(AppException.unknown(e.toString()));
    }
  }

  Employee _mapTableToModel(EmployeesTable table) {
    return Employee(
      id: table.id,
      userId: table.userId,
      designationId: table.designationId,
      categoryId: table.categoryId,
      departmentId: table.departmentId,
      name: table.name,
      phone: table.phone,
      email: table.email,
      roomNumber: table.roomNumber,
      image: table.image,
      order: table.order,
      status: table.status,
      createdAt: table.createdAt,
      updatedAt: table.updatedAt,
      isUpdated: table.isUpdated,
      imageUrl: table.imageUrl ?? '',
      designation: Designation(id: 0, title: ''), // Will be populated separately
      category: Category(id: 0, title: ''), // Will be populated separately
      department: null, // Will be populated separately
    );
  }
}