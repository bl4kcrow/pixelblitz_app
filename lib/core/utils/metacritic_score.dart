import 'package:flutter/material.dart';

import '../theme/theme.dart';

enum MetacriticScore {
  favorable(AppColors.green),
  average(AppColors.sunglow),
  unfavorable(AppColors.red);

  const MetacriticScore(
    this.color,
  );

  final Color color;

  factory MetacriticScore.getFromValue(int value) {
    if (value.clamp(0, 49) == value) {
      return MetacriticScore.unfavorable;
    } else if (value.clamp(50, 74) == value) {
      return MetacriticScore.average;
    } else {
      return MetacriticScore.favorable;
    }
  }
}
