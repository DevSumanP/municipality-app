import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerEffect extends StatelessWidget {
  final double height;
  final double width;
  const ShimmerEffect({super.key, required this.height, required this.width});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[300],
      height: height,
      width: width,
      child: Shimmer.fromColors(
        baseColor: Colors.grey,
        highlightColor: Colors.white,
        child: Container(),
      ),
    );
  }
}