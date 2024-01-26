import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../constants/constants.dart';
import '../theme/theme.dart';

class InfoALertDialog extends StatefulWidget {
  const InfoALertDialog({super.key});

  @override
  State<InfoALertDialog> createState() => _InfoALertDialogState();
}

class _InfoALertDialogState extends State<InfoALertDialog> {
  Future<PackageInfo> _getPackageInfo() async {
    return await PackageInfo.fromPlatform();
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.sizeOf(context);
    final TextTheme textTheme = Theme.of(context).textTheme;

    return AlertDialog(
      icon: Image.asset(
        Assets.appLogo,
        height: screenSize.width / 4,
        semanticLabel: SemanticLabels.pixelblitzLogo,
      ),
      content: SizedBox(
        height: screenSize.width / 2,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                Labels.dataUseRawgReference,
                style: textTheme.labelSmall,
              ),
              const SizedBox(height: Insets.small),
              GestureDetector(
                onTap: () async {
                  await launchUrlString(
                    AppConstants.rawgUrl,
                    mode: LaunchMode.externalApplication,
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.only(bottom: Insets.xsmall),
                  child: Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      Text(
                        AppConstants.rawgUrl,
                        style: textTheme.labelSmall,
                      ),
                      const SizedBox(width: Insets.xsmall),
                      const FaIcon(
                        FontAwesomeIcons.arrowUpRightFromSquare,
                        color: AppColors.melon,
                        semanticLabel: SemanticLabels.goToRawgLink,
                        size: IconSize.xsmall / 1.5,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: Insets.small),
              Text(
                Labels.dataUseBehanceInGameReference,
                style: textTheme.labelSmall,
              ),
              const SizedBox(height: Insets.small),
              Text(
                Labels.dataUserIconifyReference,
                style: textTheme.labelSmall,
              ),
              const SizedBox(height: Insets.medium),
              Text(
                Labels.pixelBlitz,
                style: textTheme.labelSmall,
                textAlign: TextAlign.end,
              ),
              const SizedBox(height: Insets.xsmall),
              FutureBuilder<PackageInfo>(
                future: _getPackageInfo(),
                builder: (
                  BuildContext context,
                  AsyncSnapshot<PackageInfo> snapshot,
                ) {
                  if (snapshot.hasData) {
                    return Text(
                      '${Labels.appVersion} ${snapshot.data?.version}+${snapshot.data?.buildNumber}',
                      style: textTheme.labelSmall,
                      textAlign: TextAlign.end,
                    );
                  } else {
                    return const SizedBox.shrink();
                  }
                },
              ),
              const SizedBox(height: Insets.xsmall),
              Text(
                '${Labels.bl4kcrowCopyright} ${DateTime.now().year}',
                style: textTheme.labelSmall,
                textAlign: TextAlign.end,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
