import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
                          borderRadius: BorderRadius.circular(10),
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
                                SvgIcon(
                                  path: platformAssetPath.path,
                                  color: isSelected
                                      ? AppColors.white
                                      : AppColors.white.withOpacity(0.7),
                                  iconSize: IconSize.small * 2,
                                ),
                                Text(
                                  platform.name,
                                  textAlign: TextAlign.center,
                                  maxLines: 2,
                                  softWrap: true,
                                  style: textTheme.bodySmall,
                                ),
                              ] else
                                Text(
                                  platform.name,
                                  textAlign: TextAlign.center,
                                  maxLines: 2,
                                  softWrap: true,
                                  style: textTheme.bodyLarge,
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
                child: Text(
                  'Clear All',
                  style: textTheme.labelMedium?.copyWith(
                    color: AppColors.melon,
                  ),
                ),
              ),
            ],
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}