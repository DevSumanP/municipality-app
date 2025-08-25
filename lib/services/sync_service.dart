import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:municipality_app/core/constants/storage_keys.dart';
import 'package:municipality_app/core/exceptions/app_exceptions.dart';
import 'package:municipality_app/core/network/network_info.dart';
import 'package:municipality_app/core/storage/local_storage.dart';
import 'package:municipality_app/data/models/sync_model.dart';
import 'package:municipality_app/data/repositories/sync_repository.dart';

final syncServiceProvider = Provider<SyncService>((ref) {
  return throw UnimplementedError('SyncService not implemented');
});

class SyncService {
  final SyncRepository syncRepository;
  final LocalStorage _localStorage = LocalStorage();

  SyncService({required this.syncRepository});

  Future<SyncModel> syncAllData({
    Function(String)? onProgress,
    Function(AppException)? onError,
  }) async {
    try {
      //  Check network connectivity
      if (!await NetworkInfo.isConnected) {
        throw AppException.noInternet('No internet connection available');
      }

      onProgress?.call('Starting sync...');

      // Mark sync as started
      await _setSyncStatus(true);

      onProgress?.call('Syncing data...');

      // Perform sync
      final result = await syncRepository.syncAllData();

      return result.fold((error) {
        onError?.call(error);
        return SyncModel(
            lastSyncTime: DateTime.now().toIso8601String(),
            syncedTables: [],
            isSyncing: false,
            error: error.message);
      }, (syncModel) async {
        onProgress?.call('Sync completed successfully');

        // Save sync time
        await _localStorage.setString(
          StorageKeys.lastSyncTime,
          syncModel.lastSyncTime,
        );

        // Mark sync completed
        await _setSyncStatus(false);

        return syncModel;
      });
    } catch (e) {
      await _setSyncStatus(false);
      final error = AppException.unknown(e.toString());
      onError?.call(error);
      return SyncModel(
        lastSyncTime: DateTime.now().toIso8601String(),
        syncedTables: [],
        isSyncing: false,
        error: error.message,
      );
    }
  }

  Future<bool> needsSync() async {
    final lastSyncTime =
        await _localStorage.getString(StorageKeys.lastSyncTime);

    if (lastSyncTime == null) return true;

    final lastSync = DateTime.parse(lastSyncTime);
    final now = DateTime.now();
    final difference = now.difference(lastSync);

    // Sync if more than 7 days have been passed
    return difference.inDays >= 7;
  }

  Future<String?> getLastSyncTime() async {
    return await _localStorage.getString(StorageKeys.lastSyncTime) ?? '';
  }

  Future<bool> isSyncing() async {
    return _localStorage.getBool('is_syncing') ?? false;
  }

  Future<void> _setSyncStatus(bool status) async {
    await _localStorage.setBool('is_syncing', status);
  }

  Future<void> clearSyncData() async {
    await _localStorage.remove(StorageKeys.lastSyncTime);
    await _localStorage.remove('is_syncing');
  }
}
