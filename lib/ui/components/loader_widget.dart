import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class LoaderContainer extends StatelessWidget {
  final double height;
  final double width;
  final double borderRadius;
  const LoaderContainer({
    super.key,
    required this.height,
    required this.width,
    this.borderRadius = 5,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Theme.of(context).primaryColor.withOpacity(0.1),
      highlightColor: Theme.of(context).primaryColor.withOpacity(0.32),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadius),
            color: Theme.of(context).primaryColor),
        height: height,
        width: width,
      ),
    );
  }
}
