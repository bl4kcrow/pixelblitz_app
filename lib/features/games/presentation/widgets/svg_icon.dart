import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/theme/theme.dart';

class SvgIcon extends StatelessWidget {
  const SvgIcon({
    super.key,
    required this.path,
    this.color = AppColors.white,
    this.iconSize = IconSize.small,
  });

  final String path;
  final Color color;
  final double iconSize;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      path,
      colorFilter: ColorFilter.mode(
        color,
        BlendMode.srcIn,
      ),
      height: iconSize,
      width: iconSize,
    );
  }
}
