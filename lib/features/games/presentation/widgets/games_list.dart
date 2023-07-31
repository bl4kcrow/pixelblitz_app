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

class GamesList extends StatelessWidget {
  const GamesList({
    super.key,
    required this.games,
    required this.listController,
  });

  final List<Game> games;
  final ScrollController listController;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final screenSize = MediaQuery.sizeOf(context);

    return ListView.separated(
      controller: listController,
      padding: EdgeInsets.zero,
      itemCount: games.length,
      itemBuilder: (context, index) {
        final Game game = games[index];
        final GoRouterState state = GoRouterState.of(context);
        final String heroId = '${state.location}-games-list-${game.id}';

        return GestureDetector(
          onTap: () {
            context.read<GameDetailsBloc>().add(
                  GetDetails(id: game.id),
                );
            context
                .read<GameScreenshotsBloc>()
                .add(GetInitialScreenshots(id: game.id));
            context
                .read<GameSeriesBloc>()
                .add(GetInitialGameSeries(id: game.id));
            context.pushNamed(
              RoutesName.gameDetailsScreen,
              extra: heroId,
            );
          },
          child: Card(
            child: Row(
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: Insets.xsmall,
                    vertical: Insets.small,
                  ),
                  width: screenSize.width * 0.4,
                  height: screenSize.width * 0.25,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(AppRadius.xsmall),
                  ),
                  child: Hero(
                    tag: heroId,
                    child: AspectRatio(
                      aspectRatio: 16 / 9,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(AppRadius.xsmall),
                        child: CachedNetworkImage(
                          imageUrl: game.backgroundImage,
                          colorBlendMode: BlendMode.darken,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: Insets.xsmall),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: Insets.xsmall,
                      vertical: Insets.small,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          game.name,
                          style: textTheme.bodyLarge,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          game.released != null
                              ? 'Release Date: ${DateFormat.yMMMd().format(game.released!)}'
                              : 'Release Date: ${Labels.notApplicable}',
                          style: textTheme.bodySmall?.copyWith(
                            color: AppColors.white.withOpacity(0.9),
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        RichText(
                          text: TextSpan(
                            text: '${Labels.metacritic}: ',
                            style: textTheme.bodySmall?.copyWith(
                              color: AppColors.white.withOpacity(0.9),
                            ),
                            children: <TextSpan>[
                              if (game.metacritic != null) ...[
                                TextSpan(
                                  text: game.metacritic.toString(),
                                  style: textTheme.bodySmall?.copyWith(
                                    color: MetacriticScore.getFromValue(
                                      game.metacritic!,
                                    ).color.withOpacity(0.9),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ] else
                                TextSpan(
                                  text: Labels.notApplicable,
                                  style: textTheme.bodySmall,
                                ),
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              'Rating: ',
                              style: textTheme.bodySmall?.copyWith(
                                color: AppColors.white.withOpacity(0.9),
                              ),
                            ),
                            Expanded(
                              child: StarRating(
                                value: game.rating,
                                color: AppColors.sunglow.withOpacity(0.9),
                                iconSize: IconSize.small / 2,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
      separatorBuilder: (_, __) {
        return const SizedBox(height: Insets.small);
      },
    );
  }
}
