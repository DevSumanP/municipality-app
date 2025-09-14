import 'package:flutter/material.dart';
import 'package:municipality_app/core/constants/sizes.dart';

class CustomErrorWidget extends StatelessWidget {
  final String errorMsg;
  final double? padding;
  final VoidCallback onTap;
  const CustomErrorWidget(
      {super.key, required this.errorMsg, required this.onTap, this.padding});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: padding ?? 0.0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 64,
              color: Colors.grey[400],
            ),
            const SizedBox(height: 16),
            Text(
              'Failed to load services',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 8),
            Text(
              errorMsg,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[500],
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: AppSizes.buttonWidth,
              child: ElevatedButton(
                onPressed: onTap,
                child: const Text('Retry'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
