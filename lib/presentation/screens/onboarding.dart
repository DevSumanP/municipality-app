import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:municipality_app/core/constants/sizes.dart';
import 'package:municipality_app/presentation/providers/sync_provider.dart';
import 'package:municipality_app/presentation/screens/auth/sync_screen.dart';
import '../../core/constants/app_images.dart';
import 'widgets/onboarding_page.dart';

class OnBoardingScreen extends ConsumerStatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  ConsumerState<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends ConsumerState<OnBoardingScreen> {
  @override
  void initState() {
    super.initState();
    // Start sync automatically when this screen loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(syncProvider.notifier).syncAllData();
    });
  }

  @override
  Widget build(BuildContext context) {
    final syncState = ref.watch(syncProvider);
    final currentProgress = syncState.currentProgress;
    final progressPercentage = syncState.progressPercentage;

    // Listen for sync completion
    ref.listen<SyncState>(syncProvider, (previous, next) {
      if (next.isCompleted && !next.hasError) {
        // Sync completed successfully, navigate to home
        Future.delayed(const Duration(seconds: 1), () {
          if (mounted) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const SyncScreen()),
            );
          }
        });
      }
    });

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Expanded(
                child: OnboardingPage(
                  title: syncState.isSyncing
                      ? 'Synchronizing Your Data'
                      : syncState.hasError
                          ? 'Sync Error'
                          : syncState.isCompleted
                              ? 'Sync Completed!'
                              : 'Ready to Sync',
                  image: AppImages.onBoardingImage1,
                  subTitle: syncState.isSyncing
                      ? 'We are updating your local data to match the latest information from our servers. This may take a few moments.'
                      : syncState.hasError
                          ? 'There was an error syncing your data. Please check your internet connection and try again.'
                          : syncState.isCompleted
                              ? 'Your data has been successfully synchronized. You can now use the app offline.'
                              : 'Your app needs to download the latest data to work offline.',
                ),
              ),

              const SizedBox(height: AppSizes.spaceBtwSections),

              // Progress Section
              if (syncState.isSyncing) ...[
                LinearProgressIndicator(
                  value: progressPercentage / 100,
                  backgroundColor: Colors.grey[300],
                  valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
                  minHeight: 8,
                ),
                const SizedBox(height: 16),
                Text(
                  currentProgress ?? 'Syncing...',
                  style: Theme.of(context).textTheme.bodyMedium,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  '${progressPercentage.toInt()}%',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ],

              // Error Section
              if (syncState.hasError) ...[
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.red[50],
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.red[200]!),
                  ),
                  child: Column(
                    children: [
                      Icon(Icons.error_outline,
                          color: Colors.red[700], size: 32),
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
                ElevatedButton(
                  onPressed: () {
                    ref
                        .read(syncProvider.notifier)
                        .syncAllData(forceSync: true);
                  },
                  child: const Text('Retry Sync'),
                ),
              ],

              // Completed Section
              if (syncState.isCompleted) ...[
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.green[50],
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.green[200]!),
                  ),
                  child: Column(
                    children: [
                      Icon(Icons.check_circle_outline,
                          color: Colors.green[700], size: 32),
                      const SizedBox(height: 8),
                      Text(
                        'Sync completed successfully!',
                        style: TextStyle(
                            color: Colors.green[700],
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                      if (syncState.syncModel?.syncedTables.isNotEmpty ==
                          true) ...[
                        const SizedBox(height: 8),
                        Text(
                          'Synced: ${syncState.syncModel!.syncedTables.join(', ')}',
                          style:
                              TextStyle(color: Colors.green[600], fontSize: 12),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SyncScreen()),
                    );
                  },
                  child: const Text('Continue to App'),
                ),
              ],

              const SizedBox(height: AppSizes.spaceBtwSections),
            ],
          ),
        ),
      ),
    );
  }
}
