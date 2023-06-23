import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/theme/theme.dart';
import '../../../../core/utils/utils.dart';
import '../../domain/domain.dart';

class PlatformsIconRow extends StatelessWidget {
  PlatformsIconRow({
    super.key,
    required this.platforms,
  }) {
    platforms.sort(
      (platformA, platformB) => platformA.slug.compareTo(platformB.slug),
    );
  }

  final List<Platform> platforms;

  Widget _svgIcon(String assetName) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Insets.xsmall),
      child: SvgPicture.asset(
        assetName,
        colorFilter: ColorFilter.mode(
          AppColors.white.withOpacity(0.7),
          BlendMode.srcIn,
        ),
        height: IconSize.small,
        width: IconSize.small,
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
      if (platformsNameIncluded.length >= 6) {
        platformsIcon.add(const Text('...'));
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
          platformsIcon.add(Text(platform.name));
          platformsNameIncluded.add(platform.name);
        }
      } else {
        platformsIcon.add(Text(platform.name));
        platformsNameIncluded.add(platform.name);
      }
    }

    return Row(
      children: [...platformsIcon],
    );
  }
}
