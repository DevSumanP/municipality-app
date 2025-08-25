import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:municipality_app/presentation/screens/auth/signin_screen.dart';
import 'core/utils/theme/theme.dart';
import 'presentation/screens/auth/sync_screen.dart';
import 'core/constants/app_constants.dart';

class MunicipalityApp extends ConsumerWidget {
  const MunicipalityApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      title: AppConstants.appName,
            themeMode: ThemeMode.system,
      theme: AppTheme.lightTheme,
      home: const SignInScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}