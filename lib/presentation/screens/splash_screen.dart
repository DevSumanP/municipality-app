import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SplashScreen extends ConsumerWidget {
  final bool showLoading;
  const SplashScreen({super.key, this.showLoading = false});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // SVG Logo
              SvgPicture.asset(
                'assets/images/auth/auth.svg',
                height: MediaQuery.of(context).size.height * 0.25,
              ),
              const SizedBox(height: 24),
              
              // App Title
              Text(
                'Municipality App',
                style: theme.textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: theme.primaryColor,
                ),
              ),
              if (showLoading) ...[
              const SizedBox(height: 24),
              const CircularProgressIndicator(),
            ],

            ],
          ),
        ),
      ),
    );
  }
}
