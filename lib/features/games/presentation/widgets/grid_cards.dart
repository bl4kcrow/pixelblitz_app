import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/routes/routes.dart';
import '../../../../core/theme/theme.dart';
import '../../domain/domain.dart';
import '../presentation.dart';

class GridCards extends StatelessWidget {
  const GridCards({
    super.key,
    required this.games,
    required this.scrollController,
  });

  final List<Game> games;
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      controller: scrollController,
      itemCount: games.length,
      padding: const EdgeInsets.all(Insets.xsmall),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        childAspectRatio: 16 / 9,
        crossAxisCount: 2,
        mainAxisSpacing: Insets.medium,
        crossAxisSpacing: Insets.small,
      ),
      itemBuilder: (context, index) {
        final Game game = games[index];
        final String heroId = 'gridView-${game.id}';

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
            context.goNamed(
              RoutesName.gameDetailsScreen,
              extra: heroId,
            );
          },
          child: Hero(
            tag: heroId,
            child: Stack(
              alignment: Alignment.bottomLeft,
              children: [
                SizedBox.expand(
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      boxShadow: const [
                        BoxShadow(
                          color: AppColors.black,
                          spreadRadius: 1.0,
                          blurRadius: 3.0,
                          offset: Offset(0.0, 0.0),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: CachedNetworkImage(
                        imageUrl: game.backgroundImage,
                        fit: BoxFit.cover,
                        memCacheHeight: 2160,
                        memCacheWidth: 3840,
                      ),
                    ),
                  ),
                ),
                SizedBox.expand(
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      gradient: const LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          AppColors.black,
                        ],
                        stops: [
                          0.5,
                          1.0,
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(Insets.small),
                  child: Text(
                    game.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
