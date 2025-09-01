import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:municipality_app/presentation/screens/onboarding/onboarding.dart';

import '../../presentation/providers/auth_provider.dart';
import '../../presentation/screens/auth/signin_screen.dart';
import '../../presentation/screens/onboarding/splash_screen.dart';

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
      return const OnBoardingScreen();
    }

    // Not authenticated, show signin
    return const SignInScreen();
  }
}