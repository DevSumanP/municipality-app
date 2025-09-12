import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:municipality_app/core/constants/storage_keys.dart';
import 'package:municipality_app/core/exceptions/app_exceptions.dart';
import 'package:municipality_app/core/network/network_info.dart';
import 'package:municipality_app/core/storage/local_storage.dart';
import 'package:municipality_app/data/models/sync_model.dart';
import 'package:municipality_app/data/repositories/sync_repository.dart';

import '../presentation/providers/sync_provider.dart';

final syncServiceProvider = Provider<SyncService>((ref) {
  return SyncService(syncRepository: ref.read(syncRepositoryProvider));
});

class SyncService {
  final SyncRepository syncRepository;
  final LocalStorage _localStorage = LocalStorage();

  SyncService({required this.syncRepository});

  Future<SyncModel> syncAllData({
    required Function(String) onProgress,
    required Function(AppException) onError,
  }) async {
    Logger().i('[SyncService] Starting syncAllData');
    
    SyncModel? finalSyncModel;
    
    try {
      // Check network connectivity first
      Logger().i('[SyncService] Checking network connectivity...');
      onProgress('Checking connection...');
      
      if (!await NetworkInfo.isConnected) {
        final error = AppException.noInternet('No internet connection. Please check your network and try again.');
        Logger().i('[SyncService] No internet connection');
        onError(error);
        return SyncModel(
          lastSyncTime: DateTime.now().toIso8601String(),
          syncedTables: [],
          isSyncing: false,
          error: error.message,
        );
      }

      onProgress('Preparing data sync...');
      Logger().i('[SyncService] Marking sync as started');
      
      // Mark sync as started
      await _setSyncStatus(true);

      onProgress('Syncing services...');
      Logger().i('[SyncService] Starting repository sync...');

      // Perform sync with detailed progress tracking
      final result = await syncRepository.syncAllData();
      onProgress('Syncing employees...');
      await Future.delayed(const Duration(milliseconds: 300));
      
      onProgress('Syncing notices...');
      await Future.delayed(const Duration(milliseconds: 300));
      
      onProgress('Syncing news...');
      await Future.delayed(const Duration(milliseconds: 300));
      
      Logger().i('[SyncService] Repository sync completed, processing result...');

      finalSyncModel = await result.fold((error) async {
        Logger().i('[SyncService] Error during sync: ${error.message}');
        
        final syncModel = SyncModel(
          lastSyncTime: DateTime.now().toIso8601String(),
          syncedTables: [],
          isSyncing: false,
          error: error.message,
        );
        
        onError(error);
        return syncModel;
      }, (syncModel) async {
        Logger().i('[SyncService] Sync completed successfully');
        Logger().i('[SyncService] Synced tables: ${syncModel.syncedTables.join(', ')}');
        
        onProgress('Finalizing sync...');
        await Future.delayed(const Duration(milliseconds: 200));

        // Save sync time and status
        Logger().i('[SyncService] Saving last sync time: ${syncModel.lastSyncTime}');
        await _localStorage.setString(
          StorageKeys.lastSyncTime,
          syncModel.lastSyncTime,
        );

        // Save synced tables info
        await _localStorage.setStringList(
          'synced_tables',
          syncModel.syncedTables,
        );

        onProgress('Sync completed successfully');
        await Future.delayed(const Duration(milliseconds: 200));
        
        return SyncModel(
          lastSyncTime: syncModel.lastSyncTime,
          syncedTables: syncModel.syncedTables,
          isSyncing: false,
          error: syncModel.error,
        );
      });

    } catch (e, stackTrace) {
      Logger().i('[SyncService] Unexpected error during sync: $e');
      Logger().i('Stack trace: $stackTrace');
      
      final error = AppException.unknown('An unexpected error occurred during sync: ${e.toString()}');
      onError(error);
      
      finalSyncModel = SyncModel(
        lastSyncTime: DateTime.now().toIso8601String(),
        syncedTables: [],
        isSyncing: false,
        error: error.message,
      );
    } finally {
      // Always mark sync as completed
      Logger().i('[SyncService] Marking sync as completed');
      await _setSyncStatus(false);
    }

    return finalSyncModel!;
  }

  Future<bool> needsSync() async {
    try {
      // Check if it's the first time or if data is missing
      final lastSyncTime = await _localStorage.getString(StorageKeys.lastSyncTime);
      final syncedTables = await _localStorage.getStringList('synced_tables') ?? [];

      // If no previous sync or no tables were synced, sync is needed
      if (lastSyncTime == null || syncedTables.isEmpty) {
        Logger().i('[SyncService] No previous sync found - sync needed');
        return true;
      }

      // Check if sync is too old
      try {
        final lastSync = DateTime.parse(lastSyncTime);
        final now = DateTime.now();
        final difference = now.difference(lastSync);

        // Sync if more than 24 hours have passed
        final needsSync = difference.inHours >= 24;
        Logger().i('[SyncService] Last sync: $lastSync, Hours since: ${difference.inHours}, Needs sync: $needsSync');
        
        return needsSync;
      } catch (e) {
        Logger().i('[SyncService] Error parsing last sync time: $e');
        return true; // If can't parse date, assume sync is needed
      }
    } catch (e) {
      Logger().i('[SyncService] Error checking sync status: $e');
      return true; // On error, assume sync is needed
    }
  }

  Future<String?> getLastSyncTime() async {
    try {
      return await _localStorage.getString(StorageKeys.lastSyncTime);
    } catch (e) {
      Logger().i('[SyncService] Error getting last sync time: $e');
      return null;
    }
  }

  Future<bool> isSyncing() async {
    try {
      return await _localStorage.getBool('is_syncing') ?? false;
    } catch (e) {
      Logger().i('[SyncService] Error checking sync status: $e');
      return false;
    }
  }

  Future<List<String>> getSyncedTables() async {
    try {
      return await _localStorage.getStringList('synced_tables') ?? [];
    } catch (e) {
      Logger().i('[SyncService] Error getting synced tables: $e');
      return [];
    }
  }

  Future<String?> getLastSyncError() async {
    try {
      return await _localStorage.getString('last_sync_error');
    } catch (e) {
      Logger().i('[SyncService] Error getting last sync error: $e');
      return null;
    }
  }

  Future<void> _setSyncStatus(bool status) async {
    try {
      await _localStorage.setBool('is_syncing', status);
    } catch (e) {
      Logger().i('[SyncService] Error setting sync status: $e');
    }
  }

  Future<void> _saveLastSyncError(String? error) async {
    try {
      if (error != null) {
        await _localStorage.setString('last_sync_error', error);
      } else {
        await _localStorage.remove('last_sync_error');
      }
    } catch (e) {
      Logger().i('[SyncService] Error saving sync error: $e');
    }
  }

  Future<void> clearSyncData() async {
    try {
      await _localStorage.remove(StorageKeys.lastSyncTime);
      await _localStorage.remove('is_syncing');
      await _localStorage.remove('synced_tables');
      await _localStorage.remove('last_sync_error');
      Logger().i('[SyncService] Sync data cleared');
    } catch (e) {
      Logger().i('[SyncService] Error clearing sync data: $e');
    }
  }

  Future<void> forceClearSyncStatus() async {
    try {
      await _localStorage.setBool('is_syncing', false);
      Logger().i('[SyncService] Sync status force cleared');
    } catch (e) {
      Logger().i('[SyncService] Error force clearing sync status: $e');
    }
  }

  String formatLastSyncTime(String? lastSyncTime) {
    if (lastSyncTime == null || lastSyncTime.isEmpty) return 'Never';
    
    try {
      final dateTime = DateTime.parse(lastSyncTime);
      final now = DateTime.now();
      final difference = now.difference(dateTime);

      if (difference.inMinutes < 1) {
        return 'Just now';
      } else if (difference.inHours < 1) {
        return '${difference.inMinutes} minutes ago';
      } else if (difference.inDays < 1) {
        return '${difference.inHours} hours ago';
      } else if (difference.inDays < 7) {
        return '${difference.inDays} days ago';
      } else {
        return dateTime.toString().split(' ')[0]; // Return date only
      }
    } catch (e) {
      return 'Unknown';
    }
  }
}