import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
    final TextTheme textTheme = Theme.of(context).textTheme;

    return GridView.builder(
      controller: scrollController,
      itemCount: games.length,
      padding: const EdgeInsets.all(Insets.xsmall),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        childAspectRatio: 16 / 9,
        crossAxisCount: 2,
        mainAxisSpacing: Insets.medium,
        crossAxisSpacing: Insets.medium,
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
            context.pushNamed(
              RoutesName.gameDetailsScreen,
              extra: heroId,
            );
          },
          child: Stack(
            alignment: Alignment.bottomLeft,
            children: [
              SizedBox.expand(
                child: Hero(
                  tag: heroId,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0),
                      boxShadow: const [
                        BoxShadow(
                          color: AppColors.charlestonGrey,
                          spreadRadius: 1.0,
                          blurRadius: 3.0,
                          offset: Offset(0.0, 3.0),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(5.0),
                      child: CachedNetworkImage(
                        imageUrl: game.backgroundImage,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox.expand(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
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
              SizedBox.expand(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    gradient: const LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.centerLeft,
                      colors: [
                        AppColors.black,
                        Colors.transparent,
                      ],
                      stops: [
                        0.1,
                        0.4,
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
              Positioned(
                right: Insets.small,
                top: Insets.xsmall,
                child: Row(
                  children: [
                    const FaIcon(
                      FontAwesomeIcons.solidStar,
                      color: AppColors.sunglow,
                      size: IconSize.large / 2,
                    ),
                    const SizedBox(width: Insets.xsmall),
                    Text(
                      game.rating.toString(),
                      style: textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
