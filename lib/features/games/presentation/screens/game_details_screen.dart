import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:pixelblitz_app/features/games/domain/domain.dart';

import '../../../../core/theme/theme.dart';
import '../../../../core/utils/utils.dart';
import '../presentation.dart';

class GameDetailsScreen extends StatelessWidget {
  const GameDetailsScreen({
    super.key,
    required this.heroId,
  });

  final String heroId;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final screenSize = MediaQuery.sizeOf(context);

    return Scaffold(
      body: BlocBuilder<GameDetailsBloc, GameDetailsState>(
        builder: (context, state) {
          if (state.requestStatus == GamesRequestStatus.success) {
            final GameDetails gameDetails = state.gameDetails;
            final String genres = gameDetails.genres.join(', ');

            return Hero(
              tag: heroId,
              child: SizedBox(
                height: screenSize.height * 0.6,
                width: double.maxFinite,
                child: AspectRatio(
                  aspectRatio: 16 / 9,
                  child: Stack(
                    children: [
                      SizedBox.expand(
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 2.0),
                          child: CachedNetworkImage(
                            imageUrl: gameDetails.backgroundImage,
                            fit: BoxFit.cover,
                            memCacheHeight: 2160,
                            memCacheWidth: 3840,
                          ),
                        ),
                      ),
                      const SizedBox.expand(
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.transparent,
                                AppColors.eerieBlack,
                              ],
                              stops: [
                                0.7,
                                1.0,
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox.expand(
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              colors: [
                                AppColors.black,
                                Colors.transparent,
                              ],
                              stops: [
                                0.0,
                                0.3,
                              ],
                            ),
                          ),
                        ),
                      ),
                      Positioned.fill(
                        child: SizedBox(
                          width: screenSize.width,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: Insets.medium,
                              vertical: Insets.large,
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  gameDetails.name,
                                  style: textTheme.headlineLarge,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                ),
                                const SizedBox(height: Insets.medium),
                                PlatformsIconRow(
                                  platforms: gameDetails.platforms,
                                ),
                                const SizedBox(height: Insets.medium),
                                Text(
                                  genres,
                                  style: textTheme.bodyMedium?.copyWith(
                                    color: AppColors.white.withOpacity(0.4),
                                  ),
                                  maxLines: 2,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: Insets.xsmall,
                        top: screenSize.height * 0.07,
                        child: IconButton(
                          onPressed: () {
                            context.pop();
                          },
                          icon: const FaIcon(FontAwesomeIcons.chevronLeft),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          }
        },
      ),
    );
  }
}
