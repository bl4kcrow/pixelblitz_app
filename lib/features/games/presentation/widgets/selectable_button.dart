import 'package:flutter/material.dart';

import '../../../../core/theme/theme.dart';

class SelectableButton extends StatelessWidget {
  const SelectableButton({
    super.key,
    required this.label,
    this.isSelected = true,
    this.onPressed,
  });

  final String label;
  final bool isSelected;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return TextButton(
      style: TextButton.styleFrom(
        backgroundColor:
            isSelected ? AppColors.black : AppColors.charlestonGrey,
        side: BorderSide(
          color: isSelected
              ? AppColors.white.withOpacity(0.7)
              : AppColors.eerieBlack,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.small),
        ),
      ),
      onPressed: onPressed,
      child: isSelected
          ? ShaderMask(
              blendMode: BlendMode.srcIn,
              shaderCallback: (Rect bounds) {
                return const LinearGradient(
                  colors: <Color>[
                    AppColors.congoPink,
                    AppColors.maroon,
                  ],
                ).createShader(
                  Rect.fromLTWH(
                    0.0,
                    0.0,
                    bounds.width,
                    bounds.height,
                  ),
                );
              },
              child: Text(
                label.toUpperCase(),
                maxLines: 2,
                textAlign: TextAlign.center,
                style: textTheme.labelMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          : Text(
              label.toUpperCase(),
              maxLines: 2,
              textAlign: TextAlign.center,
              style: textTheme.labelMedium?.copyWith(
                color: AppColors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
    );
  }
}
