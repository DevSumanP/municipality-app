import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:municipality_app/core/constants/sizes.dart';
import 'package:municipality_app/presentation/providers/sync_provider.dart';
import 'package:municipality_app/presentation/screens/home/home_screen.dart';
import 'package:municipality_app/presentation/providers/auth_provider.dart';
import '../../../core/constants/app_images.dart';
import 'widgets/onboarding_page.dart';

class OnBoardingScreen extends ConsumerStatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  ConsumerState<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends ConsumerState<OnBoardingScreen> {
  bool _syncStarted = false;

  @override
  void initState() {
    super.initState();
    _initializeSync();
  }

  void _initializeSync() {
    // Start sync automatically when this screen loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_syncStarted) {
        _syncStarted = true;
        ref.read(syncProvider.notifier).syncAllData(forceSync: true);
      }
    });
  }

  void _navigateToHome() {
    if (mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    }
  }

  void _retrySync() {
    ref.read(syncProvider.notifier).syncAllData(forceSync: true);
  }

  void _skipSync() {
    // Allow user to skip sync and go to home with limited functionality
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Skip Sync?'),
        content: const Text(
          'Skipping sync means some features may not work properly. '
          'You can sync later from the settings menu.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _navigateToHome();
            },
            child: const Text('Skip'),
          ),
        ],
      ),
    );
  }

  void _logout() async {
    await ref.read(authProvider.notifier).logout();
    if (mounted) {
      Navigator.pushReplacementNamed(context, '/signin');
    }
  }

  @override
  Widget build(BuildContext context) {
    final syncState = ref.watch(syncProvider);
    final currentProgress = syncState.currentProgress ?? 'Preparing...';
    final progressPercentage = syncState.progressPercentage;

    // Listen for sync completion
    ref.listen<SyncState>(syncProvider, (previous, next) {
      if (next.isCompleted && !next.hasError) {
        // Small delay to show completion state
        Future.delayed(const Duration(seconds: 1), () {
          if (mounted) {
            _navigateToHome();
          }
        });
      }
    });

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          if (!syncState.isSyncing && !syncState.isCompleted)
            TextButton(
              onPressed: _skipSync,
              child: const Text('Skip'),
            ),
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'logout') {
                _logout();
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'logout',
                child: Row(
                  children: [
                    Icon(Icons.logout),
                    SizedBox(width: 8),
                    Text('Logout'),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Expanded(
                child: OnboardingPage(
                  title: _getSyncTitle(syncState),
                  image: AppImages.onBoardingImage1,
                  subTitle: _getSyncSubtitle(syncState),
                ),
              ),

              const SizedBox(height: AppSizes.spaceBtwSections),

              // Progress Section
              if (syncState.isSyncing) ...[
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.blue[50],
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.blue[200]!),
                  ),
                  child: Column(
                    children: [
                      const SizedBox(height: 16),
                      Text(
                        currentProgress,
                        style: Theme.of(context).textTheme.bodyMedium,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '${progressPercentage.toInt()}%',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Colors.blue[700],
                            ),
                      ),
                    ],
                  ),
                ),
              ],

              // Error Section
              if (syncState.hasError) ...[
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.red[50],
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.red[200]!),
                  ),
                  child: Column(
                    children: [
                      Icon(Icons.error_outline,
                          color: Colors.red[700], size: 32),
                      const SizedBox(height: 12),
                      Text(
                        'Sync Failed',
                        style: TextStyle(
                          color: Colors.red[700],
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        syncState.error!,
                        style: TextStyle(color: Colors.red[700]),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: _skipSync,
                        child: const Text('Skip for Now'),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: _retrySync,
                        child: const Text('Retry'),
                      ),
                    ),
                  ],
                ),
              ],

              // Completed Section
              if (syncState.isCompleted && !syncState.hasError) ...[
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.green[50],
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.green[200]!),
                  ),
                  child: Column(
                    children: [
                      Icon(Icons.check_circle_outline,
                          color: Colors.green[700], size: 32),
                      const SizedBox(height: 12),
                      Text(
                        'Sync Completed!',
                        style: TextStyle(
                            color: Colors.green[700],
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                        textAlign: TextAlign.center,
                      ),
                      if (syncState.syncModel?.syncedTables.isNotEmpty == true) ...[
                        const SizedBox(height: 8),
                        Text(
                          'Updated: ${syncState.syncModel!.syncedTables.join(', ')}',
                          style: TextStyle(
                              color: Colors.green[600], fontSize: 12),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ],
                  ),
                ),
                // const SizedBox(height: 16),
                // SizedBox(
                //   width: double.infinity,
                //   child: ElevatedButton(
                //     onPressed: _navigateToHome,
                //     child: const Text('Continue to App'),
                //   ),
                // ),
              ],

              // const SizedBox(height: AppSizes.spaceBtwSections),
            ],
          ),
        ),
      ),
    );
  }

  String _getSyncTitle(SyncState syncState) {
    if (syncState.isSyncing) {
      return 'Synchronizing Data';
    } else if (syncState.hasError) {
      return 'Sync Error';
    } else if (syncState.isCompleted) {
      return 'All Set!';
    } else {
      return 'Ready to Sync';
    }
  }

  String _getSyncSubtitle(SyncState syncState) {
    if (syncState.isSyncing) {
      return 'We are downloading the latest data to ensure you have access to all features even when offline. This may take a few moments.';
    } else if (syncState.hasError) {
      return 'There was an error downloading data. Please check your internet connection and try again, or skip to continue with limited functionality.';
    } else if (syncState.isCompleted) {
      return 'Your data has been successfully synchronized. You can now use the app with full functionality, even offline!';
    } else {
      return 'To provide the best experience, we need to download some data. This ensures all features work properly even when you\'re offline.';
    }
  }
}