import '../../../core/database/app_database.dart';
import '../../../core/database/tables/employees_table.dart';
import '../../models/employee_model.dart';

class EmployeeLocalDataSource {
  final AppDatabase database;

  EmployeeLocalDataSource({required this.database});

  Future<List<EmployeesTable>> getAllEmployees() async {
    return await database.employeesDao.getAllEmployees();
  }

  Future<EmployeesTable?> getEmployeeById(int id) async {
    return await database.employeesDao.getEmployeeById(id);
  }

  Future<List<EmployeesTable>> getEmployeesByDepartment(String departmentId) async {
    return await database.employeesDao.getEmployeesByDepartment(departmentId);
  }

  Future<List<EmployeesTable>> getEmployeesByDesignation(int designationId) async {
    return await database.employeesDao.getEmployeesByDesignation(designationId);
  }

  Future<List<EmployeesTable>> getEmployeesByCategory(int categoryId) async {
    return await database.employeesDao.getEmployeesByCategory(categoryId);
  }

  Future<List<EmployeesTable>> getUpdatedEmployees() async {
    return await database.employeesDao.getUpdatedEmployees();
  }

  Future<void> saveEmployees(List<Employee> employees) async {
    // Clear existing employees
    await database.employeesDao.deleteAllEmployees();
    
    // Convert and insert new employees
    final employeeTables = employees.map((employee) => EmployeesTable(
      id: employee.id,
      userId: employee.userId,
      designationId: employee.designationId,
      categoryId: employee.categoryId,
      departmentId: employee.departmentId,
      name: employee.name,
      phone: employee.phone,
      email: employee.email,
      roomNumber: employee.roomNumber,
      image: employee.image,
      order: employee.order,
      status: employee.status,
      createdAt: employee.createdAt,
      updatedAt: employee.updatedAt,
      isUpdated: employee.isUpdated,
      imageUrl: employee.imageUrl,
    )).toList();

    await database.employeesDao.insertAllEmployees(employeeTables);
  }

  Future<void> saveEmployee(Employee employee) async {
    final employeeTable = EmployeesTable(
      id: employee.id,
      userId: employee.userId,
      designationId: employee.designationId,
      categoryId: employee.categoryId,
      departmentId: employee.departmentId,
      name: employee.name,
      phone: employee.phone,
      email: employee.email,
      roomNumber: employee.roomNumber,
      image: employee.image,
      order: employee.order,
      status: employee.status,
      createdAt: employee.createdAt,
      updatedAt: employee.updatedAt,
      isUpdated: employee.isUpdated,
      imageUrl: employee.imageUrl,
    );

    await database.employeesDao.insertEmployee(employeeTable);
  }

  Future<void> updateEmployee(EmployeesTable employee) async {
    await database.employeesDao.updateEmployee(employee);
  }

  Future<void> deleteEmployee(int id) async {
    await database.employeesDao.deleteEmployee(id);
  }

  Future<void> deleteAllEmployees() async {
    await database.employeesDao.deleteAllEmployees();
  }
}
