import 'package:dartz/dartz.dart';
import '../models/sync_model.dart';
import '../../core/exceptions/app_exceptions.dart';
import 'service_repository.dart';
import 'employee_repository.dart';
import 'document_repository.dart';

class SyncRepository {
  final ServiceRepository serviceRepository;
  final EmployeeRepository employeeRepository;
  final DocumentRepository documentRepository;

  SyncRepository({
    required this.serviceRepository,
    required this.employeeRepository,
    required this.documentRepository,
  });

  Future<Either<AppException, SyncModel>> syncAllData() async {
    print('[SyncRepository] Starting syncAllData');
    try {
      final List<String> syncedTables = [];
      String? lastError;

      print('[SyncRepository] Starting services sync...');
      final servicesResult = await serviceRepository.syncServices();
      servicesResult.fold(
        (error) {
          lastError = error.message;
          print('[SyncRepository] Error syncing services: ${error.message}');
        },
        (success) {
          syncedTables.add('services');
          print('[SyncRepository] Services synced successfully');
        },
      );

      print('[SyncRepository] Starting employees sync...');
      final employeesResult = await employeeRepository.syncEmployees();
      employeesResult.fold(
        (error) {
          lastError = error.message;
          print('[SyncRepository] Error syncing employees: ${error.message}');
        },
        (success) {
          syncedTables.add('employees');
          print('[SyncRepository] Employees synced successfully');
        },
      );

      print('[SyncRepository] Starting notices sync...');
      final noticesResult = await documentRepository.syncNotices();
      noticesResult.fold(
        (error) {
          lastError = error.message;
          print('[SyncRepository] Error syncing notices: ${error.message}');
        },
        (success) {
          syncedTables.add('notices');
          print('[SyncRepository] Notices synced successfully');
        },
      );

      print('[SyncRepository] Starting scrolling news sync...');
      final scrollingNewsResult = await documentRepository.syncScrollingNews();
      scrollingNewsResult.fold(
        (error) {
          lastError = error.message;
          print('[SyncRepository] Error syncing scrolling news: ${error.message}');
        },
        (success) {
          syncedTables.add('scrolling_news');
          print('[SyncRepository] Scrolling news synced successfully');
        },
      );

      final syncModel = SyncModel(
        lastSyncTime: DateTime.now().toIso8601String(),
        syncedTables: syncedTables,
        isSyncing: false,
        error: lastError,
      );

      print('[SyncRepository] Sync completed. Synced tables: ${syncedTables.join(', ')}');
      if (lastError != null) {
        print('[SyncRepository] Sync completed with errors: $lastError');
      }

      return Right(syncModel);
    } catch (e, stackTrace) {
      print('[SyncRepository] Unexpected error in syncAllData: $e');
      print('Stack trace: $stackTrace');
      return Left(AppException.unknown(e.toString()));
    }
  }

  Future<Either<AppException, bool>> needsSync() async {
    try {
      // Check if local data exists and is not too old

      return const Right(true);
    } catch (e) {
      return Left(AppException.unknown(e.toString()));
    }
  }
}
