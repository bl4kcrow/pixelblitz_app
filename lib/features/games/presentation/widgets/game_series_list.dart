import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/routes/routes.dart';
import '../../../../core/theme/theme.dart';
import '../../../../core/utils/utils.dart';
import '../../domain/domain.dart';
import '../presentation.dart';

class GameSeriesList extends StatefulWidget {
  const GameSeriesList({super.key});

  @override
  State<GameSeriesList> createState() => _GameSeriesListState();
}

class _GameSeriesListState extends State<GameSeriesList> {
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    if (scrollController.offset >= scrollController.position.maxScrollExtent &&
        !scrollController.position.outOfRange) {
      if (context.read<GameSeriesBloc>().haveNext) {
        context.read<GameSeriesBloc>().add(GetNextGameSeries());
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

    return SizedBox(
      height: screenSize.width * 0.5,
      width: double.maxFinite,
      child: BlocBuilder<GameSeriesBloc, GameSeriesState>(
        builder: (context, state) {
          if (state.requestStatus == GamesRequestStatus.success) {
            if (state.games.isEmpty) {
              return const Column(
                children: [
                  SizedBox(height: Insets.extraLarge),
                  NoDataAnimation(label: Labels.noGameSeries),
                ],
              );
            } else {
              return ListView.separated(
                controller: scrollController,
                padding: EdgeInsets.zero,
                itemCount: state.games.length,
                itemBuilder: (BuildContext context, int index) {
                  final Game currentGame = state.games[index];
                  final String heroId = 'series-list-${currentGame.id}';
                  final String formatedReleaseDate =
                      currentGame.released != null
                          ? DateFormat.yMMMd().format(currentGame.released!)
                          : Labels.notApplicable;

                  return GestureDetector(
                    onTap: () {
                      context.read<GameDetailsBloc>().add(
                            GetDetails(id: currentGame.id),
                          );
                      context
                          .read<GameScreenshotsBloc>()
                          .add(GetInitialScreenshots(id: currentGame.id));
                      context
                          .read<GameSeriesBloc>()
                          .add(GetInitialGameSeries(id: currentGame.id));
                      context.pushReplacementNamed(
                        RoutesName.gameDetailsScreen,
                        extra: heroId,
                      );
                    },
                    child: SizedBox(
                      height: screenSize.height * 0.2,
                      child: Row(
                        children: [
                          Semantics(
                            label:
                                '${index.toString()} ${SemanticLabels.clickcableImage} ${SemanticLabels.gameName} ${currentGame.name}',
                            child: Hero(
                              tag: heroId,
                              child: AspectRatio(
                                aspectRatio: 3 / 4,
                                child: ClipRRect(
                                  borderRadius:
                                      BorderRadius.circular(AppRadius.small),
                                  child: CachedNetworkImage(
                                    imageUrl: currentGame.backgroundImage,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: Insets.medium),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  currentGame.name,
                                  style: textTheme.bodyLarge,
                                  overflow: TextOverflow.ellipsis,
                                  semanticsLabel:
                                      '${SemanticLabels.gameName} ${currentGame.name}',
                                ),
                                const SizedBox(height: Insets.medium),
                                if (currentGame.released != null) ...[
                                  Text(
                                    formatedReleaseDate,
                                    style: textTheme.bodyMedium?.copyWith(
                                      color: AppColors.melon,
                                    ),
                                    semanticsLabel:
                                        '${SemanticLabels.releaseDate} $formatedReleaseDate',
                                  ),
                                  const SizedBox(height: Insets.xsmall),
                                ],
                                if (currentGame.metacritic != null) ...[
                                  RichText(
                                    text: TextSpan(
                                      text: '${Labels.metacritic} ',
                                      style: textTheme.bodyMedium?.copyWith(
                                        color: AppColors.melon,
                                      ),
                                      children: <TextSpan>[
                                        TextSpan(
                                          text:
                                              currentGame.metacritic.toString(),
                                          style: textTheme.bodyMedium?.copyWith(
                                            color: MetacriticScore.getFromValue(
                                              currentGame.metacritic!,
                                            ).color,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ] else
                                  Text(
                                    Labels.notApplicable,
                                    style: textTheme.bodyMedium?.copyWith(
                                      color: AppColors.melon,
                                    ),
                                    semanticsLabel:
                                        '${SemanticLabels.metracriticRate} Labels.notApplicable',
                                  ),
                                const SizedBox(height: Insets.xsmall),
                                Semantics(
                                  label: SemanticLabels.platformIcons,
                                  child: PlatformsIconRow(
                                    color: AppColors.melon,
                                    iconSize: IconSize.xsmall,
                                    maxPlatforms: 8,
                                    platforms: currentGame.platforms,
                                    separatorSize: Insets.xsmall / 2,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                separatorBuilder: (_, __) {
                  return const SizedBox(
                    height: Insets.medium,
                  );
                },
              );
            }
          } else {
            return const Center(
              child: SpinnerIndicator(),
            );
          }
        },
      ),
    );
  }
}
