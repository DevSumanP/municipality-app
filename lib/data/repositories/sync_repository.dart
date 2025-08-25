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
    try {
      final List<String> syncedTables = [];
      String? lastError;

      // Sync services
      final servicesResult = await serviceRepository.syncServices();
      servicesResult.fold(
        (error) => lastError = error.message,
        (success) => syncedTables.add('services'),
      );

      // Sync employees
      final employeesResult = await employeeRepository.syncEmployees();
      employeesResult.fold(
        (error) => lastError = error.message,
        (success) => syncedTables.add('employees'),
      );

      // Sync notices
      final noticesResult = await documentRepository.syncNotices();
      noticesResult.fold(
        (error) => lastError = error.message,
        (success) => syncedTables.add('notices'),
      );

      // Sync scrolling news
      final scrollingNewsResult = await documentRepository.syncScrollingNews();
      scrollingNewsResult.fold(
        (error) => lastError = error.message,
        (success) => syncedTables.add('scrolling_news'),
      );

      final syncModel = SyncModel(
        lastSyncTime: DateTime.now().toIso8601String(),
        syncedTables: syncedTables,
        isSyncing: false,
        error: lastError,
      );

      return Right(syncModel);
    } catch (e) {
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