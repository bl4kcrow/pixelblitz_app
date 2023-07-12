import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/theme/theme.dart';

class NoDataAnimation extends StatelessWidget {
  const NoDataAnimation({
    super.key,
    required this.label,
  });

  final String label;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Column(
      children: [
        const SizedBox(height: Insets.extraLarge),
        Lottie.asset(
          Assets.pacmanGhostsLottie,
          height: 70.0,
        ),
        Text(
          label,
          style: textTheme.bodyLarge?.copyWith(
            color: AppColors.white.withOpacity(0.5),
          ),
        )
      ],
    );
  }
}
