import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:municipality_app/presentation/providers/sync_provider.dart';
import 'package:municipality_app/presentation/screens/onboarding/onboarding.dart';
import 'package:municipality_app/presentation/screens/splash_screen.dart';

import 'home/home_screen.dart';

class SyncScreen extends ConsumerStatefulWidget {
  const SyncScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SyncScreenState();
}

class _SyncScreenState extends ConsumerState<SyncScreen> {
  @override
  void initState() {
    super.initState();
    _checkSyncStatus();
  }

  Future<void> _checkSyncStatus() async {
    // Import your sync service and check if sync is needed
    final syncRepository = ref.read(syncRepositoryProvider);
    final needsSyncResult = await syncRepository.needsSync();

    needsSyncResult.fold(
      (error) {
        // On error, show onboarding to trigger sync
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const OnBoardingScreen()),
        );
      },
      (needsSync) {
        if (needsSync) {
          // Needs sync, show onboarding
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const OnBoardingScreen()),
          );
        } else {
          // No sync needed, go directly to home
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const HomeScreen()),
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return const SplashScreen();
  }
}
