import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:municipality_app/core/utils/app_utils.dart';

import '../../../../core/constants/colors.dart';
import '../../../../core/constants/sizes.dart';

class OnBoardingButton extends StatelessWidget {
  const OnBoardingButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
        bottom: AppUtils.getBottomNavigationBarHeight(context) + 24,
        right: AppSizes.defaultSpace,
        child: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            shape: const CircleBorder(),
            backgroundColor: AppColors.primary,
            minimumSize: const Size(56, 56), // Standard FAB size
            padding: EdgeInsets.zero, // Remove default padding
            elevation: 2,
          ),
          child: const Icon(
            Iconsax.d_rotate,
            color: AppColors.white,
            size: 28,
          ),
        ),
    );
  }
}
