import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/theme/theme.dart';
import '../../../../core/utils/utils.dart';
import '../../domain/domain.dart';
import '../presentation.dart';

class HorizontalPlatformsList extends StatefulWidget {
  const HorizontalPlatformsList({super.key});

  @override
  State<HorizontalPlatformsList> createState() =>
      _HorizontalPlatformsListState();
}

class _HorizontalPlatformsListState extends State<HorizontalPlatformsList> {
  final ScrollController scrollController = ScrollController();
  final regExp = RegExp(
    PlatformAsset.values.map((platformAsset) => platformAsset.name).join('|'),
    caseSensitive: false,
  );
  final List<int> platformsSelected = [];

  @override
  void initState() {
    super.initState();
    scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    if (scrollController.offset >= scrollController.position.maxScrollExtent &&
        !scrollController.position.outOfRange) {
      if (context.read<PlatformsBloc>().haveNext) {
        context.read<PlatformsBloc>().add(GetNextPlatforms());
      }
    }
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);
    final TextTheme textTheme = Theme.of(context).textTheme;

    return BlocBuilder<PlatformsBloc, PlatformsState>(
      builder: (context, state) {
        if (state.requestStatus == GamesRequestStatus.success) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              SizedBox(
                width: screenSize.width,
                height: screenSize.width * 0.25,
                child: Semantics(
                  label: SemanticLabels.platformsHorizontalScroll,
                  child: ListView.separated(
                    controller: scrollController,
                    padding: EdgeInsets.zero,
                    scrollDirection: Axis.horizontal,
                    itemCount: state.platforms.length,
                    itemBuilder: (context, index) {
                      final Platform platform = state.platforms[index];
                      final regExpMatch = regExp.firstMatch(platform.slug);
                      final bool isSelected =
                          platformsSelected.contains(platform.id);
                      final String platformSemanticLabel = isSelected
                          ? '${platform.name} ${SemanticLabels.optionSelected}'
                          : '${platform.name} ${SemanticLabels.option}';

                      PlatformAsset? platformAssetPath;

                      if (regExpMatch != null) {
                        try {
                          platformAssetPath = PlatformAsset.values.firstWhere(
                            (platformAsset) =>
                                platformAsset.name == regExpMatch[0],
                          );
                        } catch (_) {}
                      }

                      return GestureDetector(
                        onTap: () {
                          if (platformsSelected.contains(platform.id)) {
                            platformsSelected.remove(platform.id);
                          } else {
                            platformsSelected.add(platform.id);
                          }

                          context
                              .read<GamesByPlatformBloc>()
                              .add(GetInitialGamesByPlatform(
                                platformIds: platformsSelected,
                              ));

                          setState(() {});
                        },
                        child: Card(
                          color: isSelected
                              ? AppColors.black
                              : AppColors.charlestonGrey,
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(AppRadius.small),
                            side: BorderSide(
                              color: isSelected
                                  ? AppColors.maroon
                                  : AppColors.eerieBlack,
                              width: 2,
                            ),
                          ),
                          child: SizedBox.square(
                            dimension: screenSize.width * 0.25,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                if (platformAssetPath != null) ...[
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: Insets.small),
                                    child: SvgIcon(
                                      path: platformAssetPath.path,
                                      color: isSelected
                                          ? AppColors.white
                                          : AppColors.white
                                              .withValues(alpha: 0.7),
                                      iconSize: IconSize.small * 2,
                                    ),
                                  ),
                                  Text(
                                    platform.name,
                                    textAlign: TextAlign.center,
                                    maxLines: AppConstants.commonMaxLines,
                                    softWrap: true,
                                    style: textTheme.bodySmall,
                                    semanticsLabel: platformSemanticLabel,
                                  ),
                                ] else
                                  Text(
                                    platform.name,
                                    textAlign: TextAlign.center,
                                    maxLines: AppConstants.commonMaxLines,
                                    softWrap: true,
                                    style: textTheme.bodyLarge,
                                    semanticsLabel: platformSemanticLabel,
                                  ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (_, __) {
                      return const SizedBox(width: Insets.small);
                    },
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  platformsSelected.clear();
                  context
                      .read<GamesByPlatformBloc>()
                      .add(GetInitialGamesByPlatform(
                        platformIds: platformsSelected,
                      ));

                  setState(() {});
                },
                child: Padding(
                  padding: const EdgeInsets.all(Insets.small),
                  child: Text(
                    Labels.clearAll,
                    style: textTheme.labelMedium?.copyWith(
                      color: AppColors.melon,
                    ),
                    semanticsLabel: SemanticLabels.clearAllButton,
                  ),
                ),
              ),
            ],
          );
        } else {
          return SizedBox(height: screenSize.width * 0.3);
        }
      },
    );
  }
}
