import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/adapters.dart';
import 'app.dart';
import 'core/storage/local_storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Hive
  await Hive.initFlutter();
  await LocalStorage.init();

  // Initialize Database
  
  runApp(
    const ProviderScope(
      // overrides: [
      //   databaseProvider.overrideWithValue(database),
      // ],
      child: MunicipalityApp(),
    ),
  );
}
