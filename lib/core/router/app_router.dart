import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:municipality_app/presentation/screens/home/home_screen.dart';

import '../../presentation/providers/auth_provider.dart';
import '../../presentation/screens/auth/signin_screen.dart';
import '../../presentation/screens/splash_screen.dart';

class AppRouter extends ConsumerWidget {
  const AppRouter({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);

    // Show loading screen while checking authentication
    if (authState.isLoading) {
      return const SplashScreen(showLoading: true);
    }

    // If authenticated, proceed to sync/home flow
    if (authState.isAuthenticated) {
      return const HomeScreen();
    }

    // Not authenticated, show signin
    return const SignInScreen();
  }
}