import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/icon_size.dart';

class StarRating extends StatelessWidget {
  const StarRating({
    super.key,
    required this.value,
    this.color = AppColors.sunglow,
    this.iconSize = IconSize.small,
  });

  final double value;
  final Color color;
  final double iconSize;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        IconData icon = FontAwesomeIcons.solidStar;

        if (index >= value) {
          icon = FontAwesomeIcons.star;
        } else if (index >= value - 0.5) {
          icon = FontAwesomeIcons.solidStarHalfStroke;
        }

        return FaIcon(
          icon,
          color: color,
          size: iconSize,
        );
      }),
    );
  }
}
