import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax/iconsax.dart';
import 'package:municipality_app/core/constants/colors.dart';

import '../../../core/constants/sizes.dart';
import '../../providers/navigation_provider.dart';

class CustomBottomNavBarExample extends ConsumerWidget {
  const CustomBottomNavBarExample({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final navigationnState = ref.watch(navigationProvider);
    return CustomBottomNavBar(
      selectedIndex: navigationnState.selectedIndex,
      onItemTapped: (index) {
        ref.read(navigationProvider.notifier).setTab(index);
      },
    );
  }
}

class CustomBottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  const CustomBottomNavBar({
    super.key,
    required this.selectedIndex,
    required this.onItemTapped,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppSizes.md),
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            height: 65,
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(AppSizes.borderRadiusLg),
            ),
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildNavItem(0, Iconsax.home, 'Home'),
                _buildNavItem(1, Iconsax.notification, 'Notices'),
                _buildNavItem(2, Iconsax.document, 'News'),
                _buildNavItem(3, Iconsax.profile_2user, 'Employees'),
                _buildNavItem(4, Iconsax.setting, 'Services'),
              ],
            ),
          ),
         
        ],
      ),
    );
  }

  Widget _buildNavItem(int index, IconData navIcon, String label) {
    final bool isSelected = index == selectedIndex;

    return InkWell(
      onTap: () => onItemTapped(index),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: AppSizes.sm),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              navIcon,
              size: 27,
              color: isSelected ? Colors.black : Colors.black54,
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? AppColors.black : Colors.black54,
                fontSize: 12,
                fontWeight: FontWeight.w700,
                height: 20 / 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
