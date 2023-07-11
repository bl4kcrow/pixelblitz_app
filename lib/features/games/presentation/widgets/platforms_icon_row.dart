import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../core/theme/theme.dart';
import '../../../../core/utils/utils.dart';
import '../../domain/domain.dart';

class PlatformsIconRow extends StatelessWidget {
  PlatformsIconRow({
    super.key,
    required this.platforms,
    this.color = AppColors.white,
    this.iconSize = IconSize.small,
    this.maxPlatforms = 6,
    this.separatorSize = Insets.xsmall,
  }) {
    platforms.sort(
      (platformA, platformB) => platformA.slug.compareTo(platformB.slug),
    );
  }
  final Color color;
  final double iconSize;
  final int maxPlatforms;
  final List<Platform> platforms;
  final double separatorSize;

  Widget _svgIcon(String assetName) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: separatorSize),
      child: SvgPicture.asset(
        assetName,
        colorFilter: ColorFilter.mode(
          color,
          BlendMode.srcIn,
        ),
        height: iconSize,
        width: iconSize,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> platformsIcon = [];
    final List<String> platformsNameIncluded = [];
    final regExp = RegExp(
      PlatformAsset.values.map((platformAsset) => platformAsset.name).join('|'),
      caseSensitive: false,
    );

    for (var platform in platforms) {
      if (platformsNameIncluded.length >= maxPlatforms) {
        platformsIcon.add(
          Padding(
            padding: EdgeInsets.symmetric(horizontal: separatorSize),
            child: FaIcon(
              FontAwesomeIcons.ellipsis,
              color: color,
              size: iconSize,
            ),
          ),
        );
        break;
      }

      final regExpMatch = regExp.firstMatch(platform.slug);

      if (regExpMatch != null) {
        try {
          final platformIconPath = PlatformAsset.values.firstWhere(
            (platformAsset) => platformAsset.name == regExpMatch[0],
          );

          if (platformsNameIncluded.contains(platformIconPath.name)) {
            continue;
          }

          platformsIcon.add(_svgIcon(platformIconPath.path));
          platformsNameIncluded.add(platformIconPath.name);
        } catch (_) {
          platformsIcon.add(
            Text(
              platform.name,
              style: TextStyle(color: color),
            ),
          );
          platformsNameIncluded.add(platform.name);
        }
      } else {
        platformsIcon.add(
          Text(
            platform.name,
            style: TextStyle(color: color),
          ),
        );
        platformsNameIncluded.add(platform.name);
      }
    }

    return Row(
      children: [...platformsIcon],
    );
  }
}
