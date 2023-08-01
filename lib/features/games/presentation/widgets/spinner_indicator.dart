import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/theme/theme.dart';

class SpinnerIndicator extends StatelessWidget {
  const SpinnerIndicator({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(Insets.small),
      child: Lottie.asset(
        Assets.circleSpinner,
        height: 70.0,
      ),
    );
  }
}
