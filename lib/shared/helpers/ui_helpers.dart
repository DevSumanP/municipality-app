import 'package:flutter/material.dart';

import '../../core/constants/app_dimensions.dart';

class UIHelpers {
  static Widget addVerticalSpace(double height) => SizedBox(height: height);
  static Widget addHorizontalSpace(double width) => SizedBox(width: width);

  static EdgeInsets symmetricPadding({
    double horizontal = 0,
    double vertical = 0,
  }) =>
      EdgeInsets.symmetric(horizontal: horizontal, vertical: vertical);

  static BorderRadius circularBorder(double radius) =>
      BorderRadius.circular(radius);

  static BoxShadow defaultShadow() => BoxShadow(
        color: Colors.black.withValues(alpha: 0.1),
        offset: const Offset(0, AppDimensions.cardElevation),
        blurRadius: AppDimensions.cardBlurRadius,
        spreadRadius: 0,
      );
}
