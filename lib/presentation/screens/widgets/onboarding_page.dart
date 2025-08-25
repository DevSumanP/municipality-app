import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:municipality_app/core/utils/app_utils.dart';

import '../../../core/constants/sizes.dart';

class OnboardingPage extends StatelessWidget {
  final String title, image, subTitle;
  const OnboardingPage({
    super.key,
    required this.title,
    required this.image,
    required this.subTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SvgPicture.asset(
          image,
          width: AppUtils.getScreenWidth(context) * 0.7,
          height: AppUtils.getScreenHeight(context) * 0.7,
        ),
        Text(
          title,
          style: Theme.of(context).textTheme.headlineMedium,
          textAlign: TextAlign.center,
        ),
        const SizedBox(
          height: AppSizes.spaceBtwItems,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal:16),
          child: Text(
            subTitle,
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
