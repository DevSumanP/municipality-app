import 'package:drift/drift.dart';

@DataClassName('ServicesTable')
class Services extends Table {
  IntColumn get id => integer()();
  TextColumn get userId => text()();
  TextColumn get departmentId => text().nullable()();
  TextColumn get title => text()();
  TextColumn get description => text()();
  TextColumn get proposalSample => text().nullable()();
  TextColumn get video => text().nullable()();
  TextColumn get extraDocument => text().nullable()();
  TextColumn get status => text()();
  TextColumn get order => text()();
  TextColumn get createdAt => text()();
  TextColumn get updatedAt => text()();
  TextColumn get isUpdated => text()();
  TextColumn get videoUrl => text().nullable()();
  TextColumn get fileUrl => text().nullable()();
  TextColumn get extraFileUrl => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}