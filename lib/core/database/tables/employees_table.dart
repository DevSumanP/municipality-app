import 'package:drift/drift.dart';

@DataClassName('EmployeesTable')
class Employees extends Table {
  IntColumn get id => integer()();
  TextColumn get userId => text()();
  TextColumn get designationId => text()();
  TextColumn get categoryId => text()();
  TextColumn get departmentId => text().nullable()();
  TextColumn get name => text()();
  TextColumn get phone => text().nullable()();
  TextColumn get email => text().nullable()();
  TextColumn get roomNumber => text().nullable()();
  TextColumn get image => text().nullable()();
  TextColumn get order => text()();
  TextColumn get status => text()();
  TextColumn get createdAt => text()();
  TextColumn get updatedAt => text()();
  TextColumn get isUpdated => text()();
  TextColumn get imageUrl => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}