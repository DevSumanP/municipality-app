import 'dart:async';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

import 'tables/services_table.dart';
import 'tables/employees_table.dart';
import 'tables/media_files_table.dart';
import 'tables/documents_table.dart';
import 'tables/app_metadata_table.dart';

part 'app_database.g.dart';

@Database(
  version: 2, // Incremented to trigger database recreation
  entities: [
    ServicesTable,
    EmployeesTable,
    MediaFilesTable,
    DocumentsTable,
    AppMetadataTable,
  ],
)
abstract class AppDatabase extends FloorDatabase {
  ServicesDao get servicesDao;
  EmployeesDao get employeesDao;
  MediaFilesDao get mediaFilesDao;
  DocumentsDao get documentsDao;
  AppMetadataDao get appMetadataDao;
}

// Database DAOs
@dao
abstract class ServicesDao {
  @Query('SELECT * FROM services WHERE status = 1 ORDER BY `order` ASC')
  Future<List<ServicesTable>> getAllServices();

  @Query('SELECT * FROM services WHERE id = :id')
  Future<ServicesTable?> getServiceById(int id);

  @Query('SELECT * FROM services WHERE department_id = :departmentId ORDER BY `order` ASC')
  Future<List<ServicesTable>> getServicesByDepartment(int departmentId);

  @Query('SELECT * FROM services WHERE is_updated = 1')
  Future<List<ServicesTable>> getUpdatedServices();

  @insert
  Future<void> insertService(ServicesTable service);

  @insert
  Future<void> insertAllServices(List<ServicesTable> services);

  @update
  Future<void> updateService(ServicesTable service);

  @Query('DELETE FROM services')
  Future<void> deleteAllServices();

  @Query('DELETE FROM services WHERE id = :id')
  Future<void> deleteService(int id);
}

@dao
abstract class EmployeesDao {
  @Query('SELECT * FROM employees WHERE status = 1 ORDER BY `order` ASC')
  Future<List<EmployeesTable>> getAllEmployees();

  @Query('SELECT * FROM employees WHERE id = :id')
  Future<EmployeesTable?> getEmployeeById(int id);

  @Query('SELECT * FROM employees WHERE department_id = :departmentId ORDER BY `order` ASC')
  Future<List<EmployeesTable>> getEmployeesByDepartment(int departmentId);

  @Query('SELECT * FROM employees WHERE designation_id = :designationId')
  Future<List<EmployeesTable>> getEmployeesByDesignation(int designationId);

  @Query('SELECT * FROM employees WHERE category_id = :categoryId')
  Future<List<EmployeesTable>> getEmployeesByCategory(int categoryId);

  @Query('SELECT * FROM employees WHERE is_updated = 1')
  Future<List<EmployeesTable>> getUpdatedEmployees();

  @insert
  Future<void> insertEmployee(EmployeesTable employee);

  @insert
  Future<void> insertAllEmployees(List<EmployeesTable> employees);

  @update
  Future<void> updateEmployee(EmployeesTable employee);

  @Query('DELETE FROM employees')
  Future<void> deleteAllEmployees();

  @Query('DELETE FROM employees WHERE id = :id')
  Future<void> deleteEmployee(int id);
}

@dao
abstract class MediaFilesDao {
  @Query('SELECT * FROM media_files ORDER BY created_at DESC')
  Future<List<MediaFilesTable>> getAllMediaFiles();

  @Query('SELECT * FROM media_files WHERE id = :id')
  Future<MediaFilesTable?> getMediaFileById(int id);

  @Query('SELECT * FROM media_files WHERE type = :type ORDER BY created_at DESC')
  Future<List<MediaFilesTable>> getMediaFilesByType(String type);

  @Query('SELECT * FROM media_files WHERE is_downloaded = 1')
  Future<List<MediaFilesTable>> getDownloadedMediaFiles();

  @insert
  Future<void> insertMediaFile(MediaFilesTable mediaFile);

  @insert
  Future<void> insertAllMediaFiles(List<MediaFilesTable> mediaFiles);

  @update
  Future<void> updateMediaFile(MediaFilesTable mediaFile);

  @Query('DELETE FROM media_files')
  Future<void> deleteAllMediaFiles();

  @Query('DELETE FROM media_files WHERE id = :id')
  Future<void> deleteMediaFile(int id);
}

@dao
abstract class DocumentsDao {
  @Query('SELECT * FROM documents WHERE status = 1 ORDER BY created_at DESC')
  Future<List<DocumentsTable>> getAllDocuments();

  @Query('SELECT * FROM documents WHERE id = :id')
  Future<DocumentsTable?> getDocumentById(int id);

  @Query('SELECT * FROM documents WHERE type = :type ORDER BY created_at DESC')
  Future<List<DocumentsTable>> getDocumentsByType(String type);

  @Query('SELECT * FROM documents WHERE is_downloaded = 1')
  Future<List<DocumentsTable>> getDownloadedDocuments();

  @insert
  Future<void> insertDocument(DocumentsTable document);

  @insert
  Future<void> insertAllDocuments(List<DocumentsTable> documents);

  @update
  Future<void> updateDocument(DocumentsTable document);

  @Query('DELETE FROM documents')
  Future<void> deleteAllDocuments();

  @Query('DELETE FROM documents WHERE id = :id')
  Future<void> deleteDocument(int id);
}

@dao
abstract class AppMetadataDao {
  @Query('SELECT * FROM app_metadata WHERE key = :key')
  Future<AppMetadataTable?> getMetadata(String key);

  @Query('SELECT * FROM app_metadata')
  Future<List<AppMetadataTable>> getAllMetadata();

  @insert
  Future<void> insertMetadata(AppMetadataTable metadata);

  @update
  Future<void> updateMetadata(AppMetadataTable metadata);

  @Query('DELETE FROM app_metadata WHERE key = :key')
  Future<void> deleteMetadata(String key);

  @Query('DELETE FROM app_metadata')
  Future<void> deleteAllMetadata();
}