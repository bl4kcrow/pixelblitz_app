import 'package:flutter/material.dart';

import 'theme.dart';

final appTheme = ThemeData(
  useMaterial3: true,
  colorScheme: const ColorScheme(
    brightness: Brightness.dark,
    primary: AppColors.congoPink,
    onPrimary: AppColors.white,
    secondary: AppColors.maroon,
    onSecondary: AppColors.white,
    tertiary: AppColors.maximumPurple,
    onTertiary: AppColors.white,
    error: AppColors.melon,
    onError: AppColors.bloodRed,
    background: AppColors.eerieBlack,
    onBackground: AppColors.white,
    surface: AppColors.eerieBlack,
    onSurface: AppColors.white,
    surfaceTint: AppColors.eerieBlack,
  ),
  fontFamily: 'Satoshi',
  splashColor: Colors.transparent,
  highlightColor: Colors.transparent,
  textTheme: Typography().white.copyWith(
        displayLarge: AppTextStyle.displayLarge,
        displayMedium: AppTextStyle.displayMedium,
        displaySmall: AppTextStyle.displaySmall,
        headlineLarge: AppTextStyle.headlineLarge,
        headlineMedium: AppTextStyle.headlineMedium,
        headlineSmall: AppTextStyle.headlineSmall,
        titleLarge: AppTextStyle.titleLarge,
        titleMedium: AppTextStyle.titleMedium,
        titleSmall: AppTextStyle.titleSmall,
        labelLarge: AppTextStyle.labelLarge,
        labelMedium: AppTextStyle.labelMedium,
        labelSmall: AppTextStyle.labelSmall,
        bodyLarge: AppTextStyle.bodyLarge,
        bodyMedium: AppTextStyle.bodyMedium,
        bodySmall: AppTextStyle.bodySmall,
      ),
);
