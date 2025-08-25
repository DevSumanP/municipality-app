import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:municipality_app/core/database/app_database.dart';
import 'package:municipality_app/main.dart';

// Provider that gives access to the global database instance
final appDatabaseProvider = Provider<AppDatabase>((ref) {
  return database;
});
