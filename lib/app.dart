import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'presentation/screens/auth/sync_screen.dart';
import 'core/constants/app_constants.dart';

class MunicipalityApp extends ConsumerWidget {
  const MunicipalityApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      title: AppConstants.appName,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
          elevation: 4,
        ),
      ),
      home: const SyncScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}