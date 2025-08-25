import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:municipality_app/core/constants/sizes.dart';
import '../../core/constants/app_images.dart';
import 'widgets/onboarding_button.dart';
import 'widgets/onboarding_page.dart';

class OnBoardingScreen extends ConsumerStatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  ConsumerState<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends ConsumerState<OnBoardingScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(children: [
        // Horizontal Scrollable Page
        OnboardingPage(
          title: 'Synchronizing Your Data Securely',
          image: AppImages.onBoardingImage1,
          subTitle:
              "We are updating your local data to match the latest information from our servers. "
              ,
        ),

        SizedBox(height: AppSizes.spaceBtwSections),

        // Circular Button
        OnBoardingButton(),
      ]),
    );
  }
}
