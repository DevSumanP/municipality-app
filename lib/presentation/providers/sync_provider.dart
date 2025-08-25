import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/sync_model.dart';
import '../../data/repositories/sync_repository.dart';
import '../../services/sync_service.dart';
import '../../core/exceptions/app_exceptions.dart';

// Sync repository provider (needs to be defined)
final syncRepositoryProvider = Provider<SyncRepository>((ref) {
  // This would need the actual repository dependencies
  return throw UnimplementedError('SyncRepository not implemented');
});

// Sync state
class SyncState {
  final bool isSyncing;
  final SyncModel? syncModel;
  final String? error;
  final String? currentProgress;
  final double progressPercentage;

  const SyncState({
    this.isSyncing = false,
    this.syncModel,
    this.error,
    this.currentProgress,
    this.progressPercentage = 0.0,
  });

  SyncState copyWith({
    bool? isSyncing,
    SyncModel? syncModel,
    String? error,
    String? currentProgress,
    double? progressPercentage,
  }) {
    return SyncState(
      isSyncing: isSyncing ?? this.isSyncing,
      syncModel: syncModel ?? this.syncModel,
      error: error ?? this.error,
      currentProgress: currentProgress ?? this.currentProgress,
      progressPercentage: progressPercentage ?? this.progressPercentage,
    );
  }

  bool get hasError => error != null;
  bool get isCompleted => syncModel != null && !isSyncing;
  bool get needsInitialSync => syncModel == null && !isSyncing;
}

// Sync provider
class SyncNotifier extends StateNotifier<SyncState> {
  final SyncService _syncService;

  SyncNotifier(this._syncService) : super(const SyncState());

  Future<void> syncAllData({bool forceSync = false}) async {
    if (state.isSyncing) return;

    // Check if sync is needed
    if (!forceSync && !await _syncService.needsSync()) {
      return;
    }

    state = state.copyWith(
      isSyncing: true,
      error: null,
      currentProgress: 'Preparing sync...',
      progressPercentage: 0.0,
    );

    try {
      final syncModel = await _syncService.syncAllData(
        onProgress: (progress) {
          state = state.copyWith(
            currentProgress: progress,
            progressPercentage: _calculateProgress(progress),
          );
        },
        onError: (error) {
          state = state.copyWith(
            error: error.message,
            isSyncing: false,
          );
        },
      );

      if (syncModel.error == null) {
        state = state.copyWith(
          isSyncing: false,
          syncModel: syncModel,
          error: null,
          currentProgress: 'Sync completed',
          progressPercentage: 100.0,
        );
      } else {
        state = state.copyWith(
          isSyncing: false,
          error: syncModel.error,
          currentProgress: null,
          progressPercentage: 0.0,
        );
      }
    } catch (e) {
      state = state.copyWith(
        isSyncing: false,
        error: e.toString(),
        currentProgress: null,
        progressPercentage: 0.0,
      );
    }
  }

  Future<void> checkSyncStatus() async {
    final lastSyncTime = await _syncService.getLastSyncTime();
    final needsSync = await _syncService.needsSync();

    if (lastSyncTime != null && !needsSync) {
      state = state.copyWith(
        syncModel: SyncModel(
          lastSyncTime: lastSyncTime,
          syncedTables: [],
          isSyncing: false,
          error: null,
        ),
      );
    }
  }

  double _calculateProgress(String progressMessage) {
    // Simple progress calculation based on message content
    if (progressMessage.contains('Starting')) return 10.0;
    if (progressMessage.contains('services')) return 25.0;
    if (progressMessage.contains('employees')) return 50.0;
    if (progressMessage.contains('notices')) return 75.0;
    if (progressMessage.contains('completed')) return 100.0;
    return state.progressPercentage;
  }

  void clearError() {
    state = state.copyWith(error: null);
  }

  void reset() {
    state = const SyncState();
  }

  String? get lastSyncTimeFormatted {
    if (state.syncModel?.lastSyncTime == null) return null;
    
    try {
      final dateTime = DateTime.parse(state.syncModel!.lastSyncTime);
      final now = DateTime.now();
      final difference = now.difference(dateTime);

      if (difference.inMinutes < 1) {
        return 'Just now';
      } else if (difference.inHours < 1) {
        return '${difference.inMinutes} minutes ago';
      } else if (difference.inDays < 1) {
        return '${difference.inHours} hours ago';
      } else {
        return '${difference.inDays} days ago';
      }
    } catch (e) {
      return 'Unknown';
    }
  }
}

// Provider for sync notifier
final syncProvider = StateNotifierProvider<SyncNotifier, SyncState>((ref) {
  final syncService = ref.read(syncServiceProvider);
  return SyncNotifier(syncService);
});

// Convenience providers
final isSyncingProvider = Provider<bool>((ref) {
  return ref.watch(syncProvider).isSyncing;
});

final syncErrorProvider = Provider<String?>((ref) {
  return ref.watch(syncProvider).error;
});

final lastSyncTimeProvider = Provider<String?>((ref) {
  return ref.watch(syncProvider.notifier).lastSyncTimeFormatted;
});

final syncProgressProvider = Provider<double>((ref) {
  return ref.watch(syncProvider).progressPercentage;
});

final needsInitialSyncProvider = Provider<bool>((ref) {
  return ref.watch(syncProvider).needsInitialSync;
});