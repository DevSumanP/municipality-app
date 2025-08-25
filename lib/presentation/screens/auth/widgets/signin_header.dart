import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/constants/sizes.dart';

class LoginHeader extends StatelessWidget {
  const LoginHeader({
    super.key,
  });


  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // SvgPicture.asset(
        //   Images.logo,
        //   height: 60,
        //   width: 120,
        //   fit: BoxFit.fitHeight,
        // ),
        Text(
          'Welcome back,',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const SizedBox(
          height: AppSizes.sm,
        ),
        Text(
          'Discover Limitless Choices and Unlimited Convenience.',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
  }
}
