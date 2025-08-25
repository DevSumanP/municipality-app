import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:municipality_app/core/database/app_database.dart';
import 'app.dart';
import 'core/storage/local_storage.dart';

// Create a global database instance
late final AppDatabase database;

void main() async {
  // Ensure Flutter binding is initialized
  WidgetsFlutterBinding.ensureInitialized();

  try {
    // Initialize Hive
    await Hive.initFlutter();
    await LocalStorage.init();

    // Initialize and open the database
    database = await $FloorAppDatabase
        .databaseBuilder('app_database.db')
        .build();
    
    debugPrint('Database initialized successfully');

    // Run the app
    
    runApp(const ProviderScope(child: MunicipalityApp()));
  } catch (e, stackTrace) {
    // Print any initialization errors
    debugPrint('Error initializing app: $e');
    debugPrint('Stack trace: $stackTrace');
    rethrow;
  }
}
