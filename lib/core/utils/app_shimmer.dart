import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../theme/theme.dart';

class AppShimmer extends StatelessWidget {
  const AppShimmer({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColors.eerieBlack,
      direction: ShimmerDirection.btt,
      highlightColor: AppColors.charlestonGrey,
      period: const Duration(milliseconds: 3000),
      child: child,
    );
  }
}
