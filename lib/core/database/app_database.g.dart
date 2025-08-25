// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

abstract class $AppDatabaseBuilderContract {
  /// Adds migrations to the builder.
  $AppDatabaseBuilderContract addMigrations(List<Migration> migrations);

  /// Adds a database [Callback] to the builder.
  $AppDatabaseBuilderContract addCallback(Callback callback);

  /// Creates the database and initializes it.
  Future<AppDatabase> build();
}

// ignore: avoid_classes_with_only_static_members
class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $AppDatabaseBuilderContract databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $AppDatabaseBuilderContract inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder implements $AppDatabaseBuilderContract {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  @override
  $AppDatabaseBuilderContract addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  @override
  $AppDatabaseBuilderContract addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  @override
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  ServicesDao? _servicesDaoInstance;

  EmployeesDao? _employeesDaoInstance;

  MediaFilesDao? _mediaFilesDaoInstance;

  DocumentsDao? _documentsDaoInstance;

  AppMetadataDao? _appMetadataDaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 2,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `ServicesTable` (`id` INTEGER NOT NULL, `userId` TEXT NOT NULL, `departmentId` INTEGER, `title` TEXT NOT NULL, `description` TEXT NOT NULL, `proposalSample` TEXT, `video` TEXT, `extraDocument` TEXT, `status` TEXT NOT NULL, `order` TEXT NOT NULL, `createdAt` TEXT NOT NULL, `updatedAt` TEXT NOT NULL, `isUpdated` TEXT NOT NULL, `videoUrl` TEXT, `fileUrl` TEXT, `extraFileUrl` TEXT, `localVideoPath` TEXT, `localFilePath` TEXT, `localExtraFilePath` TEXT, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `EmployeesTable` (`id` INTEGER NOT NULL, `userId` TEXT NOT NULL, `designationId` TEXT NOT NULL, `categoryId` TEXT NOT NULL, `departmentId` INTEGER, `name` TEXT NOT NULL, `phone` TEXT, `email` TEXT, `roomNumber` TEXT, `image` TEXT, `order` TEXT NOT NULL, `status` TEXT NOT NULL, `createdAt` TEXT NOT NULL, `updatedAt` TEXT NOT NULL, `isUpdated` TEXT NOT NULL, `imageUrl` TEXT, `localImagePath` TEXT, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `MediaFilesTable` (`id` INTEGER NOT NULL, `userId` TEXT NOT NULL, `title` TEXT NOT NULL, `type` TEXT NOT NULL, `url` TEXT NOT NULL, `localPath` TEXT, `isDownloaded` INTEGER NOT NULL, `createdAt` TEXT NOT NULL, `updatedAt` TEXT NOT NULL, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `DocumentsTable` (`id` INTEGER NOT NULL, `userId` TEXT NOT NULL, `title` TEXT NOT NULL, `description` TEXT NOT NULL, `type` TEXT NOT NULL, `imageUrl` TEXT, `fileUrl` TEXT, `localImagePath` TEXT, `localFilePath` TEXT, `isDownloaded` INTEGER NOT NULL, `status` TEXT NOT NULL, `createdAt` TEXT NOT NULL, `updatedAt` TEXT NOT NULL, `isUpdated` TEXT NOT NULL, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `AppMetadataTable` (`key` TEXT NOT NULL, `value` TEXT NOT NULL, `updatedAt` TEXT NOT NULL, PRIMARY KEY (`key`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  ServicesDao get servicesDao {
    return _servicesDaoInstance ??= _$ServicesDao(database, changeListener);
  }

  @override
  EmployeesDao get employeesDao {
    return _employeesDaoInstance ??= _$EmployeesDao(database, changeListener);
  }

  @override
  MediaFilesDao get mediaFilesDao {
    return _mediaFilesDaoInstance ??= _$MediaFilesDao(database, changeListener);
  }

  @override
  DocumentsDao get documentsDao {
    return _documentsDaoInstance ??= _$DocumentsDao(database, changeListener);
  }

  @override
  AppMetadataDao get appMetadataDao {
    return _appMetadataDaoInstance ??=
        _$AppMetadataDao(database, changeListener);
  }
}

class _$ServicesDao extends ServicesDao {
  _$ServicesDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _servicesTableInsertionAdapter = InsertionAdapter(
            database,
            'ServicesTable',
            (ServicesTable item) => <String, Object?>{
                  'id': item.id,
                  'userId': item.userId,
                  'departmentId': item.departmentId,
                  'title': item.title,
                  'description': item.description,
                  'proposalSample': item.proposalSample,
                  'video': item.video,
                  'extraDocument': item.extraDocument,
                  'status': item.status,
                  'order': item.order,
                  'createdAt': item.createdAt,
                  'updatedAt': item.updatedAt,
                  'isUpdated': item.isUpdated,
                  'videoUrl': item.videoUrl,
                  'fileUrl': item.fileUrl,
                  'extraFileUrl': item.extraFileUrl,
                  'localVideoPath': item.localVideoPath,
                  'localFilePath': item.localFilePath,
                  'localExtraFilePath': item.localExtraFilePath
                }),
        _servicesTableUpdateAdapter = UpdateAdapter(
            database,
            'ServicesTable',
            ['id'],
            (ServicesTable item) => <String, Object?>{
                  'id': item.id,
                  'userId': item.userId,
                  'departmentId': item.departmentId,
                  'title': item.title,
                  'description': item.description,
                  'proposalSample': item.proposalSample,
                  'video': item.video,
                  'extraDocument': item.extraDocument,
                  'status': item.status,
                  'order': item.order,
                  'createdAt': item.createdAt,
                  'updatedAt': item.updatedAt,
                  'isUpdated': item.isUpdated,
                  'videoUrl': item.videoUrl,
                  'fileUrl': item.fileUrl,
                  'extraFileUrl': item.extraFileUrl,
                  'localVideoPath': item.localVideoPath,
                  'localFilePath': item.localFilePath,
                  'localExtraFilePath': item.localExtraFilePath
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<ServicesTable> _servicesTableInsertionAdapter;

  final UpdateAdapter<ServicesTable> _servicesTableUpdateAdapter;

  @override
  Future<List<ServicesTable>> getAllServices() async {
    return _queryAdapter.queryList(
        'SELECT * FROM services WHERE status = 1 ORDER BY `order` ASC',
        mapper: (Map<String, Object?> row) => ServicesTable(
            id: row['id'] as int,
            userId: row['userId'] as String,
            departmentId: row['departmentId'] as int?,
            title: row['title'] as String,
            description: row['description'] as String,
            proposalSample: row['proposalSample'] as String?,
            video: row['video'] as String?,
            extraDocument: row['extraDocument'] as String?,
            status: row['status'] as String,
            order: row['order'] as String,
            createdAt: row['createdAt'] as String,
            updatedAt: row['updatedAt'] as String,
            isUpdated: row['isUpdated'] as String,
            videoUrl: row['videoUrl'] as String?,
            fileUrl: row['fileUrl'] as String?,
            extraFileUrl: row['extraFileUrl'] as String?,
            localVideoPath: row['localVideoPath'] as String?,
            localFilePath: row['localFilePath'] as String?,
            localExtraFilePath: row['localExtraFilePath'] as String?));
  }

  @override
  Future<ServicesTable?> getServiceById(int id) async {
    return _queryAdapter.query('SELECT * FROM services WHERE id = ?1',
        mapper: (Map<String, Object?> row) => ServicesTable(
            id: row['id'] as int,
            userId: row['userId'] as String,
            departmentId: row['departmentId'] as int?,
            title: row['title'] as String,
            description: row['description'] as String,
            proposalSample: row['proposalSample'] as String?,
            video: row['video'] as String?,
            extraDocument: row['extraDocument'] as String?,
            status: row['status'] as String,
            order: row['order'] as String,
            createdAt: row['createdAt'] as String,
            updatedAt: row['updatedAt'] as String,
            isUpdated: row['isUpdated'] as String,
            videoUrl: row['videoUrl'] as String?,
            fileUrl: row['fileUrl'] as String?,
            extraFileUrl: row['extraFileUrl'] as String?,
            localVideoPath: row['localVideoPath'] as String?,
            localFilePath: row['localFilePath'] as String?,
            localExtraFilePath: row['localExtraFilePath'] as String?),
        arguments: [id]);
  }

  @override
  Future<List<ServicesTable>> getServicesByDepartment(int departmentId) async {
    return _queryAdapter.queryList(
        'SELECT * FROM services WHERE department_id = ?1 ORDER BY `order` ASC',
        mapper: (Map<String, Object?> row) => ServicesTable(
            id: row['id'] as int,
            userId: row['userId'] as String,
            departmentId: row['departmentId'] as int?,
            title: row['title'] as String,
            description: row['description'] as String,
            proposalSample: row['proposalSample'] as String?,
            video: row['video'] as String?,
            extraDocument: row['extraDocument'] as String?,
            status: row['status'] as String,
            order: row['order'] as String,
            createdAt: row['createdAt'] as String,
            updatedAt: row['updatedAt'] as String,
            isUpdated: row['isUpdated'] as String,
            videoUrl: row['videoUrl'] as String?,
            fileUrl: row['fileUrl'] as String?,
            extraFileUrl: row['extraFileUrl'] as String?,
            localVideoPath: row['localVideoPath'] as String?,
            localFilePath: row['localFilePath'] as String?,
            localExtraFilePath: row['localExtraFilePath'] as String?),
        arguments: [departmentId]);
  }

  @override
  Future<List<ServicesTable>> getUpdatedServices() async {
    return _queryAdapter.queryList(
        'SELECT * FROM services WHERE is_updated = 1',
        mapper: (Map<String, Object?> row) => ServicesTable(
            id: row['id'] as int,
            userId: row['userId'] as String,
            departmentId: row['departmentId'] as int?,
            title: row['title'] as String,
            description: row['description'] as String,
            proposalSample: row['proposalSample'] as String?,
            video: row['video'] as String?,
            extraDocument: row['extraDocument'] as String?,
            status: row['status'] as String,
            order: row['order'] as String,
            createdAt: row['createdAt'] as String,
            updatedAt: row['updatedAt'] as String,
            isUpdated: row['isUpdated'] as String,
            videoUrl: row['videoUrl'] as String?,
            fileUrl: row['fileUrl'] as String?,
            extraFileUrl: row['extraFileUrl'] as String?,
            localVideoPath: row['localVideoPath'] as String?,
            localFilePath: row['localFilePath'] as String?,
            localExtraFilePath: row['localExtraFilePath'] as String?));
  }

  @override
  Future<void> deleteAllServices() async {
    await _queryAdapter.queryNoReturn('DELETE FROM services');
  }

  @override
  Future<void> deleteService(int id) async {
    await _queryAdapter
        .queryNoReturn('DELETE FROM services WHERE id = ?1', arguments: [id]);
  }

  @override
  Future<void> insertService(ServicesTable service) async {
    await _servicesTableInsertionAdapter.insert(
        service, OnConflictStrategy.abort);
  }

  @override
  Future<void> insertAllServices(List<ServicesTable> services) async {
    await _servicesTableInsertionAdapter.insertList(
        services, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateService(ServicesTable service) async {
    await _servicesTableUpdateAdapter.update(service, OnConflictStrategy.abort);
  }
}

class _$EmployeesDao extends EmployeesDao {
  _$EmployeesDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _employeesTableInsertionAdapter = InsertionAdapter(
            database,
            'EmployeesTable',
            (EmployeesTable item) => <String, Object?>{
                  'id': item.id,
                  'userId': item.userId,
                  'designationId': item.designationId,
                  'categoryId': item.categoryId,
                  'departmentId': item.departmentId,
                  'name': item.name,
                  'phone': item.phone,
                  'email': item.email,
                  'roomNumber': item.roomNumber,
                  'image': item.image,
                  'order': item.order,
                  'status': item.status,
                  'createdAt': item.createdAt,
                  'updatedAt': item.updatedAt,
                  'isUpdated': item.isUpdated,
                  'imageUrl': item.imageUrl,
                  'localImagePath': item.localImagePath
                }),
        _employeesTableUpdateAdapter = UpdateAdapter(
            database,
            'EmployeesTable',
            ['id'],
            (EmployeesTable item) => <String, Object?>{
                  'id': item.id,
                  'userId': item.userId,
                  'designationId': item.designationId,
                  'categoryId': item.categoryId,
                  'departmentId': item.departmentId,
                  'name': item.name,
                  'phone': item.phone,
                  'email': item.email,
                  'roomNumber': item.roomNumber,
                  'image': item.image,
                  'order': item.order,
                  'status': item.status,
                  'createdAt': item.createdAt,
                  'updatedAt': item.updatedAt,
                  'isUpdated': item.isUpdated,
                  'imageUrl': item.imageUrl,
                  'localImagePath': item.localImagePath
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<EmployeesTable> _employeesTableInsertionAdapter;

  final UpdateAdapter<EmployeesTable> _employeesTableUpdateAdapter;

  @override
  Future<List<EmployeesTable>> getAllEmployees() async {
    return _queryAdapter.queryList(
        'SELECT * FROM employees WHERE status = 1 ORDER BY `order` ASC',
        mapper: (Map<String, Object?> row) => EmployeesTable(
            id: row['id'] as int,
            userId: row['userId'] as String,
            designationId: row['designationId'] as String,
            categoryId: row['categoryId'] as String,
            departmentId: row['departmentId'] as int?,
            name: row['name'] as String,
            phone: row['phone'] as String?,
            email: row['email'] as String?,
            roomNumber: row['roomNumber'] as String?,
            image: row['image'] as String?,
            order: row['order'] as String,
            status: row['status'] as String,
            createdAt: row['createdAt'] as String,
            updatedAt: row['updatedAt'] as String,
            isUpdated: row['isUpdated'] as String,
            imageUrl: row['imageUrl'] as String?,
            localImagePath: row['localImagePath'] as String?));
  }

  @override
  Future<EmployeesTable?> getEmployeeById(int id) async {
    return _queryAdapter.query('SELECT * FROM employees WHERE id = ?1',
        mapper: (Map<String, Object?> row) => EmployeesTable(
            id: row['id'] as int,
            userId: row['userId'] as String,
            designationId: row['designationId'] as String,
            categoryId: row['categoryId'] as String,
            departmentId: row['departmentId'] as int?,
            name: row['name'] as String,
            phone: row['phone'] as String?,
            email: row['email'] as String?,
            roomNumber: row['roomNumber'] as String?,
            image: row['image'] as String?,
            order: row['order'] as String,
            status: row['status'] as String,
            createdAt: row['createdAt'] as String,
            updatedAt: row['updatedAt'] as String,
            isUpdated: row['isUpdated'] as String,
            imageUrl: row['imageUrl'] as String?,
            localImagePath: row['localImagePath'] as String?),
        arguments: [id]);
  }

  @override
  Future<List<EmployeesTable>> getEmployeesByDepartment(
      int departmentId) async {
    return _queryAdapter.queryList(
        'SELECT * FROM employees WHERE department_id = ?1 ORDER BY `order` ASC',
        mapper: (Map<String, Object?> row) => EmployeesTable(
            id: row['id'] as int,
            userId: row['userId'] as String,
            designationId: row['designationId'] as String,
            categoryId: row['categoryId'] as String,
            departmentId: row['departmentId'] as int?,
            name: row['name'] as String,
            phone: row['phone'] as String?,
            email: row['email'] as String?,
            roomNumber: row['roomNumber'] as String?,
            image: row['image'] as String?,
            order: row['order'] as String,
            status: row['status'] as String,
            createdAt: row['createdAt'] as String,
            updatedAt: row['updatedAt'] as String,
            isUpdated: row['isUpdated'] as String,
            imageUrl: row['imageUrl'] as String?,
            localImagePath: row['localImagePath'] as String?),
        arguments: [departmentId]);
  }

  @override
  Future<List<EmployeesTable>> getEmployeesByDesignation(
      int designationId) async {
    return _queryAdapter.queryList(
        'SELECT * FROM employees WHERE designation_id = ?1',
        mapper: (Map<String, Object?> row) => EmployeesTable(
            id: row['id'] as int,
            userId: row['userId'] as String,
            designationId: row['designationId'] as String,
            categoryId: row['categoryId'] as String,
            departmentId: row['departmentId'] as int?,
            name: row['name'] as String,
            phone: row['phone'] as String?,
            email: row['email'] as String?,
            roomNumber: row['roomNumber'] as String?,
            image: row['image'] as String?,
            order: row['order'] as String,
            status: row['status'] as String,
            createdAt: row['createdAt'] as String,
            updatedAt: row['updatedAt'] as String,
            isUpdated: row['isUpdated'] as String,
            imageUrl: row['imageUrl'] as String?,
            localImagePath: row['localImagePath'] as String?),
        arguments: [designationId]);
  }

  @override
  Future<List<EmployeesTable>> getEmployeesByCategory(int categoryId) async {
    return _queryAdapter.queryList(
        'SELECT * FROM employees WHERE category_id = ?1',
        mapper: (Map<String, Object?> row) => EmployeesTable(
            id: row['id'] as int,
            userId: row['userId'] as String,
            designationId: row['designationId'] as String,
            categoryId: row['categoryId'] as String,
            departmentId: row['departmentId'] as int?,
            name: row['name'] as String,
            phone: row['phone'] as String?,
            email: row['email'] as String?,
            roomNumber: row['roomNumber'] as String?,
            image: row['image'] as String?,
            order: row['order'] as String,
            status: row['status'] as String,
            createdAt: row['createdAt'] as String,
            updatedAt: row['updatedAt'] as String,
            isUpdated: row['isUpdated'] as String,
            imageUrl: row['imageUrl'] as String?,
            localImagePath: row['localImagePath'] as String?),
        arguments: [categoryId]);
  }

  @override
  Future<List<EmployeesTable>> getUpdatedEmployees() async {
    return _queryAdapter.queryList(
        'SELECT * FROM employees WHERE is_updated = 1',
        mapper: (Map<String, Object?> row) => EmployeesTable(
            id: row['id'] as int,
            userId: row['userId'] as String,
            designationId: row['designationId'] as String,
            categoryId: row['categoryId'] as String,
            departmentId: row['departmentId'] as int?,
            name: row['name'] as String,
            phone: row['phone'] as String?,
            email: row['email'] as String?,
            roomNumber: row['roomNumber'] as String?,
            image: row['image'] as String?,
            order: row['order'] as String,
            status: row['status'] as String,
            createdAt: row['createdAt'] as String,
            updatedAt: row['updatedAt'] as String,
            isUpdated: row['isUpdated'] as String,
            imageUrl: row['imageUrl'] as String?,
            localImagePath: row['localImagePath'] as String?));
  }

  @override
  Future<void> deleteAllEmployees() async {
    await _queryAdapter.queryNoReturn('DELETE FROM employees');
  }

  @override
  Future<void> deleteEmployee(int id) async {
    await _queryAdapter
        .queryNoReturn('DELETE FROM employees WHERE id = ?1', arguments: [id]);
  }

  @override
  Future<void> insertEmployee(EmployeesTable employee) async {
    await _employeesTableInsertionAdapter.insert(
        employee, OnConflictStrategy.abort);
  }

  @override
  Future<void> insertAllEmployees(List<EmployeesTable> employees) async {
    await _employeesTableInsertionAdapter.insertList(
        employees, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateEmployee(EmployeesTable employee) async {
    await _employeesTableUpdateAdapter.update(
        employee, OnConflictStrategy.abort);
  }
}

class _$MediaFilesDao extends MediaFilesDao {
  _$MediaFilesDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _mediaFilesTableInsertionAdapter = InsertionAdapter(
            database,
            'MediaFilesTable',
            (MediaFilesTable item) => <String, Object?>{
                  'id': item.id,
                  'userId': item.userId,
                  'title': item.title,
                  'type': item.type,
                  'url': item.url,
                  'localPath': item.localPath,
                  'isDownloaded': item.isDownloaded ? 1 : 0,
                  'createdAt': item.createdAt,
                  'updatedAt': item.updatedAt
                }),
        _mediaFilesTableUpdateAdapter = UpdateAdapter(
            database,
            'MediaFilesTable',
            ['id'],
            (MediaFilesTable item) => <String, Object?>{
                  'id': item.id,
                  'userId': item.userId,
                  'title': item.title,
                  'type': item.type,
                  'url': item.url,
                  'localPath': item.localPath,
                  'isDownloaded': item.isDownloaded ? 1 : 0,
                  'createdAt': item.createdAt,
                  'updatedAt': item.updatedAt
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<MediaFilesTable> _mediaFilesTableInsertionAdapter;

  final UpdateAdapter<MediaFilesTable> _mediaFilesTableUpdateAdapter;

  @override
  Future<List<MediaFilesTable>> getAllMediaFiles() async {
    return _queryAdapter.queryList(
        'SELECT * FROM media_files ORDER BY created_at DESC',
        mapper: (Map<String, Object?> row) => MediaFilesTable(
            id: row['id'] as int,
            userId: row['userId'] as String,
            title: row['title'] as String,
            type: row['type'] as String,
            url: row['url'] as String,
            localPath: row['localPath'] as String?,
            isDownloaded: (row['isDownloaded'] as int) != 0,
            createdAt: row['createdAt'] as String,
            updatedAt: row['updatedAt'] as String));
  }

  @override
  Future<MediaFilesTable?> getMediaFileById(int id) async {
    return _queryAdapter.query('SELECT * FROM media_files WHERE id = ?1',
        mapper: (Map<String, Object?> row) => MediaFilesTable(
            id: row['id'] as int,
            userId: row['userId'] as String,
            title: row['title'] as String,
            type: row['type'] as String,
            url: row['url'] as String,
            localPath: row['localPath'] as String?,
            isDownloaded: (row['isDownloaded'] as int) != 0,
            createdAt: row['createdAt'] as String,
            updatedAt: row['updatedAt'] as String),
        arguments: [id]);
  }

  @override
  Future<List<MediaFilesTable>> getMediaFilesByType(String type) async {
    return _queryAdapter.queryList(
        'SELECT * FROM media_files WHERE type = ?1 ORDER BY created_at DESC',
        mapper: (Map<String, Object?> row) => MediaFilesTable(
            id: row['id'] as int,
            userId: row['userId'] as String,
            title: row['title'] as String,
            type: row['type'] as String,
            url: row['url'] as String,
            localPath: row['localPath'] as String?,
            isDownloaded: (row['isDownloaded'] as int) != 0,
            createdAt: row['createdAt'] as String,
            updatedAt: row['updatedAt'] as String),
        arguments: [type]);
  }

  @override
  Future<List<MediaFilesTable>> getDownloadedMediaFiles() async {
    return _queryAdapter.queryList(
        'SELECT * FROM media_files WHERE is_downloaded = 1',
        mapper: (Map<String, Object?> row) => MediaFilesTable(
            id: row['id'] as int,
            userId: row['userId'] as String,
            title: row['title'] as String,
            type: row['type'] as String,
            url: row['url'] as String,
            localPath: row['localPath'] as String?,
            isDownloaded: (row['isDownloaded'] as int) != 0,
            createdAt: row['createdAt'] as String,
            updatedAt: row['updatedAt'] as String));
  }

  @override
  Future<void> deleteAllMediaFiles() async {
    await _queryAdapter.queryNoReturn('DELETE FROM media_files');
  }

  @override
  Future<void> deleteMediaFile(int id) async {
    await _queryAdapter.queryNoReturn('DELETE FROM media_files WHERE id = ?1',
        arguments: [id]);
  }

  @override
  Future<void> insertMediaFile(MediaFilesTable mediaFile) async {
    await _mediaFilesTableInsertionAdapter.insert(
        mediaFile, OnConflictStrategy.abort);
  }

  @override
  Future<void> insertAllMediaFiles(List<MediaFilesTable> mediaFiles) async {
    await _mediaFilesTableInsertionAdapter.insertList(
        mediaFiles, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateMediaFile(MediaFilesTable mediaFile) async {
    await _mediaFilesTableUpdateAdapter.update(
        mediaFile, OnConflictStrategy.abort);
  }
}

class _$DocumentsDao extends DocumentsDao {
  _$DocumentsDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _documentsTableInsertionAdapter = InsertionAdapter(
            database,
            'DocumentsTable',
            (DocumentsTable item) => <String, Object?>{
                  'id': item.id,
                  'userId': item.userId,
                  'title': item.title,
                  'description': item.description,
                  'type': item.type,
                  'imageUrl': item.imageUrl,
                  'fileUrl': item.fileUrl,
                  'localImagePath': item.localImagePath,
                  'localFilePath': item.localFilePath,
                  'isDownloaded': item.isDownloaded ? 1 : 0,
                  'status': item.status,
                  'createdAt': item.createdAt,
                  'updatedAt': item.updatedAt,
                  'isUpdated': item.isUpdated
                }),
        _documentsTableUpdateAdapter = UpdateAdapter(
            database,
            'DocumentsTable',
            ['id'],
            (DocumentsTable item) => <String, Object?>{
                  'id': item.id,
                  'userId': item.userId,
                  'title': item.title,
                  'description': item.description,
                  'type': item.type,
                  'imageUrl': item.imageUrl,
                  'fileUrl': item.fileUrl,
                  'localImagePath': item.localImagePath,
                  'localFilePath': item.localFilePath,
                  'isDownloaded': item.isDownloaded ? 1 : 0,
                  'status': item.status,
                  'createdAt': item.createdAt,
                  'updatedAt': item.updatedAt,
                  'isUpdated': item.isUpdated
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<DocumentsTable> _documentsTableInsertionAdapter;

  final UpdateAdapter<DocumentsTable> _documentsTableUpdateAdapter;

  @override
  Future<List<DocumentsTable>> getAllDocuments() async {
    return _queryAdapter.queryList(
        'SELECT * FROM documents WHERE status = 1 ORDER BY created_at DESC',
        mapper: (Map<String, Object?> row) => DocumentsTable(
            id: row['id'] as int,
            userId: row['userId'] as String,
            title: row['title'] as String,
            description: row['description'] as String,
            type: row['type'] as String,
            imageUrl: row['imageUrl'] as String?,
            fileUrl: row['fileUrl'] as String?,
            localImagePath: row['localImagePath'] as String?,
            localFilePath: row['localFilePath'] as String?,
            isDownloaded: (row['isDownloaded'] as int) != 0,
            status: row['status'] as String,
            createdAt: row['createdAt'] as String,
            updatedAt: row['updatedAt'] as String,
            isUpdated: row['isUpdated'] as String));
  }

  @override
  Future<DocumentsTable?> getDocumentById(int id) async {
    return _queryAdapter.query('SELECT * FROM documents WHERE id = ?1',
        mapper: (Map<String, Object?> row) => DocumentsTable(
            id: row['id'] as int,
            userId: row['userId'] as String,
            title: row['title'] as String,
            description: row['description'] as String,
            type: row['type'] as String,
            imageUrl: row['imageUrl'] as String?,
            fileUrl: row['fileUrl'] as String?,
            localImagePath: row['localImagePath'] as String?,
            localFilePath: row['localFilePath'] as String?,
            isDownloaded: (row['isDownloaded'] as int) != 0,
            status: row['status'] as String,
            createdAt: row['createdAt'] as String,
            updatedAt: row['updatedAt'] as String,
            isUpdated: row['isUpdated'] as String),
        arguments: [id]);
  }

  @override
  Future<List<DocumentsTable>> getDocumentsByType(String type) async {
    return _queryAdapter.queryList(
        'SELECT * FROM documents WHERE type = ?1 ORDER BY created_at DESC',
        mapper: (Map<String, Object?> row) => DocumentsTable(
            id: row['id'] as int,
            userId: row['userId'] as String,
            title: row['title'] as String,
            description: row['description'] as String,
            type: row['type'] as String,
            imageUrl: row['imageUrl'] as String?,
            fileUrl: row['fileUrl'] as String?,
            localImagePath: row['localImagePath'] as String?,
            localFilePath: row['localFilePath'] as String?,
            isDownloaded: (row['isDownloaded'] as int) != 0,
            status: row['status'] as String,
            createdAt: row['createdAt'] as String,
            updatedAt: row['updatedAt'] as String,
            isUpdated: row['isUpdated'] as String),
        arguments: [type]);
  }

  @override
  Future<List<DocumentsTable>> getDownloadedDocuments() async {
    return _queryAdapter.queryList(
        'SELECT * FROM documents WHERE is_downloaded = 1',
        mapper: (Map<String, Object?> row) => DocumentsTable(
            id: row['id'] as int,
            userId: row['userId'] as String,
            title: row['title'] as String,
            description: row['description'] as String,
            type: row['type'] as String,
            imageUrl: row['imageUrl'] as String?,
            fileUrl: row['fileUrl'] as String?,
            localImagePath: row['localImagePath'] as String?,
            localFilePath: row['localFilePath'] as String?,
            isDownloaded: (row['isDownloaded'] as int) != 0,
            status: row['status'] as String,
            createdAt: row['createdAt'] as String,
            updatedAt: row['updatedAt'] as String,
            isUpdated: row['isUpdated'] as String));
  }

  @override
  Future<void> deleteAllDocuments() async {
    await _queryAdapter.queryNoReturn('DELETE FROM documents');
  }

  @override
  Future<void> deleteDocument(int id) async {
    await _queryAdapter
        .queryNoReturn('DELETE FROM documents WHERE id = ?1', arguments: [id]);
  }

  @override
  Future<void> insertDocument(DocumentsTable document) async {
    await _documentsTableInsertionAdapter.insert(
        document, OnConflictStrategy.abort);
  }

  @override
  Future<void> insertAllDocuments(List<DocumentsTable> documents) async {
    await _documentsTableInsertionAdapter.insertList(
        documents, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateDocument(DocumentsTable document) async {
    await _documentsTableUpdateAdapter.update(
        document, OnConflictStrategy.abort);
  }
}

class _$AppMetadataDao extends AppMetadataDao {
  _$AppMetadataDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _appMetadataTableInsertionAdapter = InsertionAdapter(
            database,
            'AppMetadataTable',
            (AppMetadataTable item) => <String, Object?>{
                  'key': item.key,
                  'value': item.value,
                  'updatedAt': item.updatedAt
                }),
        _appMetadataTableUpdateAdapter = UpdateAdapter(
            database,
            'AppMetadataTable',
            ['key'],
            (AppMetadataTable item) => <String, Object?>{
                  'key': item.key,
                  'value': item.value,
                  'updatedAt': item.updatedAt
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<AppMetadataTable> _appMetadataTableInsertionAdapter;

  final UpdateAdapter<AppMetadataTable> _appMetadataTableUpdateAdapter;

  @override
  Future<AppMetadataTable?> getMetadata(String key) async {
    return _queryAdapter.query('SELECT * FROM app_metadata WHERE key = ?1',
        mapper: (Map<String, Object?> row) => AppMetadataTable(
            key: row['key'] as String,
            value: row['value'] as String,
            updatedAt: row['updatedAt'] as String),
        arguments: [key]);
  }

  @override
  Future<List<AppMetadataTable>> getAllMetadata() async {
    return _queryAdapter.queryList('SELECT * FROM app_metadata',
        mapper: (Map<String, Object?> row) => AppMetadataTable(
            key: row['key'] as String,
            value: row['value'] as String,
            updatedAt: row['updatedAt'] as String));
  }

  @override
  Future<void> deleteMetadata(String key) async {
    await _queryAdapter.queryNoReturn('DELETE FROM app_metadata WHERE key = ?1',
        arguments: [key]);
  }

  @override
  Future<void> deleteAllMetadata() async {
    await _queryAdapter.queryNoReturn('DELETE FROM app_metadata');
  }

  @override
  Future<void> insertMetadata(AppMetadataTable metadata) async {
    await _appMetadataTableInsertionAdapter.insert(
        metadata, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateMetadata(AppMetadataTable metadata) async {
    await _appMetadataTableUpdateAdapter.update(
        metadata, OnConflictStrategy.abort);
  }
}
