import 'package:flutter/material.dart';
import 'package:municipality_app/core/constants/sizes.dart';

class SpacingStyles {
  static const EdgeInsetsGeometry paddingWithAppBarHeight = EdgeInsets.only(
    top: AppSizes.appBarHeight,
    left: AppSizes.defaultSpace,
    right: AppSizes.defaultSpace,
    bottom: AppSizes.defaultSpace,
  );
}