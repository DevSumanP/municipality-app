import 'dart:async';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:municipality_app/core/database/daos/documents_dao.dart';
import 'package:municipality_app/core/database/daos/employees_dao.dart';
import 'package:municipality_app/core/database/daos/media_files_dao.dart';
import 'package:municipality_app/core/database/daos/services_dao.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'dart:io';

import 'tables/services_table.dart';
import 'tables/employees_table.dart';
import 'tables/media_files_table.dart';
import 'tables/documents_table.dart';

part 'app_database.g.dart';

@DriftDatabase(
  tables: [
    Documents,
    Employees,
    Services,
    MediaFiles,
  ],
  daos: [
    DocumentsDao,
    EmployeesDao,
    ServicesDao,
    MediaFilesDao,
  ],
)

class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (Migrator m) async{
        await m.createAll();
      },
      onUpgrade: (Migrator m, int from, int to) async{
        // Handles migration upgraders here
        if (from < 2) {

        }
      },
      beforeOpen: (details) async{
        await customStatement('PRAGMA foreign_keys = ON');
      },
    );
  }

  // Helper method to clear all data
  Future<void> clearAllData() async {
    await transaction(() async {
      await documentsDao.deleteAllDocuments();
      await employeesDao.deleteAllEmployees();
      await servicesDao.deleteAllServices();
      await mediaFilesDao.deleteAllMediaFiles();
    });
  }

  // Helper method to get database size
  Future<int> getDatabaseSize() async {
    try {
      final dbFolder = await getApplicationDocumentsDirectory();
      final file = File(p.join(dbFolder.path, 'municipality_app.db'));
      if (await file.exists()) {
        return await file.length();
      }
      return 0;
    } catch (e) {
      return 0;
    }
  }

  // Helper method to check if database has data
  Future<bool> hasData() async {
    final documentsCount = await documentsDao.getDocumentsCount();
    final employeesCount = await employeesDao.getEmployeesCount();
    final servicesCount = await servicesDao.getServicesCount();
    
    return documentsCount > 0 || employeesCount > 0 || servicesCount > 0;
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async{
    final dbFolder = await getApplicationDocumentsDirectory();
     final file = File(p.join(dbFolder.path, 'municipality_app.db'));
    
    return NativeDatabase.createInBackground(file);
  });
}