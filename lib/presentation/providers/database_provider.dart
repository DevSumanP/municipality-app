import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:municipality_app/main.dart' show database;
import 'package:municipality_app/core/database/app_database.dart';

final appDatabaseProvider = Provider<AppDatabase>((ref) {
  return database;
});
