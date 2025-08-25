class SyncModel {
  final String lastSyncTime;
  final List<String> syncedTables;
  final bool isSyncing;
  final String? error;

  SyncModel({
    required this.lastSyncTime,
    required this.syncedTables,
    required this.isSyncing,
    this.error,
  });

  factory SyncModel.fromJson(Map<String, dynamic> json) {
    return SyncModel(
      lastSyncTime: json['last_sync_time'] ?? '',
      syncedTables: List<String>.from(json['synced_tables'] ?? []),
      isSyncing: json['is_syncing'] ?? false,
      error: json['error'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'last_sync_time': lastSyncTime,
      'synced_tables': syncedTables,
      'is_syncing': isSyncing,
      'error': error,
    };
  }
}
