import 'package:drift/drift.dart';
import '../app_database.dart';
import '../tables/employees_table.dart';

part 'employees_dao.g.dart';

@DriftAccessor(tables: [Employees])
class EmployeesDao extends DatabaseAccessor<AppDatabase> with _$EmployeesDaoMixin {
  EmployeesDao(AppDatabase db) : super(db);

  // Get all employees
  Future<List<EmployeesTable>> getAllEmployees() async {
    return await (select(employees)
      ..orderBy([(tbl) => OrderingTerm(expression: tbl.order)])
    ).get();
  }

  // Get employee by ID
  Future<EmployeesTable?> getEmployeeById(int id) async {
    return await (select(employees)..where((tbl) => tbl.id.equals(id))).getSingleOrNull();
  }

  // Get employees by department
  Future<List<EmployeesTable>> getEmployeesByDepartment(String departmentId) async {
    return await (select(employees)
      ..where((tbl) => tbl.departmentId.equals(departmentId))
      ..orderBy([(tbl) => OrderingTerm(expression: tbl.order)])
    ).get();
  }

  // Get employees by designation
  Future<List<EmployeesTable>> getEmployeesByDesignation(int designationId) async {
    return await (select(employees)
      ..where((tbl) => tbl.designationId.equals(designationId.toString()))
      ..orderBy([(tbl) => OrderingTerm(expression: tbl.order)])
    ).get();
  }

  // Get employees by category
  Future<List<EmployeesTable>> getEmployeesByCategory(int categoryId) async {
    return await (select(employees)
      ..where((tbl) => tbl.categoryId.equals(categoryId.toString()))
      ..orderBy([(tbl) => OrderingTerm(expression: tbl.order)])
    ).get();
  }

  // Get employees count
  Future<int> getEmployeesCount() async {
    final query = selectOnly(employees)..addColumns([employees.id.count()]);
    final result = await query.getSingle();
    return result.read(employees.id.count()) ?? 0;
  }

  // Get employees count by department
  Future<int> getEmployeesCountByDepartment(String departmentId) async {
    final query = selectOnly(employees)
      ..addColumns([employees.id.count()])
      ..where(employees.departmentId.equals(departmentId));
    final result = await query.getSingle();
    return result.read(employees.id.count()) ?? 0;
  }

  // Insert single employee
  Future<int> insertEmployee(EmployeesTable employee) async {
    return await into(employees).insert(employee, mode: InsertMode.insertOrReplace);
  }

  // Insert multiple employees
  Future<void> insertAllEmployees(List<EmployeesTable> employeesList) async {
    await batch((batch) {
      batch.insertAllOnConflictUpdate(employees, employeesList);
    });
  }

  // Update employee
  Future<bool> updateEmployee(EmployeesTable employee) async {
    return await update(employees).replace(employee);
  }

  // Delete employee
  Future<int> deleteEmployee(int id) async {
    return await (delete(employees)..where((tbl) => tbl.id.equals(id))).go();
  }

  // Delete employees by department
  Future<int> deleteEmployeesByDepartment(String departmentId) async {
    return await (delete(employees)..where((tbl) => tbl.departmentId.equals(departmentId))).go();
  }

  // Delete all employees
  Future<int> deleteAllEmployees() async {
    return await delete(employees).go();
  }

  // Search employees
  Future<List<EmployeesTable>> searchEmployees(String query) async {
    return await (select(employees)
      ..where((tbl) => 
        tbl.name.contains(query) | 
        tbl.email.contains(query) |
        tbl.phone.contains(query))
      ..orderBy([(tbl) => OrderingTerm(expression: tbl.name)])
    ).get();
  }

  // Get employees with email
  Future<List<EmployeesTable>> getEmployeesWithEmail() async {
    return await (select(employees)
      ..where((tbl) => tbl.email.isNotNull())
      ..orderBy([(tbl) => OrderingTerm(expression: tbl.name)])
    ).get();
  }

  // Get employees with phone
  Future<List<EmployeesTable>> getEmployeesWithPhone() async {
    return await (select(employees)
      ..where((tbl) => tbl.phone.isNotNull())
      ..orderBy([(tbl) => OrderingTerm(expression: tbl.name)])
    ).get();
  }

  // Get updated employees
  Future<List<EmployeesTable>> getUpdatedEmployees() async {
    return await (select(employees)
      ..where((tbl) => tbl.isUpdated.equals('1'))
      ..orderBy([(tbl) => OrderingTerm(expression: tbl.updatedAt, mode: OrderingMode.desc)])
    ).get();
  }

  // Get active employees
  Future<List<EmployeesTable>> getActiveEmployees() async {
    return await (select(employees)
      ..where((tbl) => tbl.status.equals('1'))
      ..orderBy([(tbl) => OrderingTerm(expression: tbl.order)])
    ).get();
  }

  // Get employees by status
  Future<List<EmployeesTable>> getEmployeesByStatus(String status) async {
    return await (select(employees)
      ..where((tbl) => tbl.status.equals(status))
      ..orderBy([(tbl) => OrderingTerm(expression: tbl.order)])
    ).get();
  }
}