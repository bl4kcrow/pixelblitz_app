import 'package:cached_network_image/cached_network_image.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';


import '../../../../core/routes/routes.dart';
import '../../../../core/theme/theme.dart';
import '../../domain/domain.dart';
import '../presentation.dart';

class _ActiveSwiperLine extends StatelessWidget {
  const _ActiveSwiperLine(this.itemSize);

  final double itemSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 5.0,
      width: itemSize - Insets.xsmall,
      margin: const EdgeInsets.symmetric(horizontal: Insets.xsmall / 2),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            AppColors.congoPink,
            AppColors.maroon,
          ],
        ),
        borderRadius: BorderRadius.circular(2.0),
      ),
    );
  }
}

class _InactiveSwiperLine extends StatelessWidget {
  const _InactiveSwiperLine(this.itemSize);

  final double itemSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 3.0,
      width: itemSize - Insets.xsmall,
      margin: const EdgeInsets.symmetric(horizontal: Insets.xsmall / 2),
      decoration: BoxDecoration(
        color: AppColors.charlestonGrey,
        borderRadius: BorderRadius.circular(2.0),
      ),
    );
  }
}

class CardSwiper extends StatelessWidget {
  CardSwiper({
    super.key,
    required this.games,
  });

  final List<Game> games;

  final SwiperPagination _swiperPagination = SwiperPagination(
    margin: const EdgeInsets.only(bottom: Insets.xsmall),
    builder: SwiperCustomPagination(
      builder: (context, config) {
        final List<Widget> list = <Widget>[];

        final screenSize = MediaQuery.sizeOf(context);

        final itemSize =
            (screenSize.width - (Insets.medium * 2)) / (config.itemCount + 1);

        for (var i = 0; i < config.itemCount; i++) {
          if (i == config.activeIndex) {
            list.add(
              _ActiveSwiperLine(itemSize * 2),
            );
          } else {
            list.add(
              _InactiveSwiperLine(itemSize),
            );
          }
        }

        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [...list],
        );
      },
    ),
  );

  Widget _swiperItemBuilder(
    BuildContext context,
    int index,
  ) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final screenSize = MediaQuery.sizeOf(context);

    final Game currentGame = games[index];
    final String genres = currentGame.genres.join(', ');
    final String heroId = 'swiper-${currentGame.id}';

    return GestureDetector(
      onTap: () {
        context.read<GameDetailsBloc>().add(GetDetails(id: currentGame.id));
        context.goNamed(
          RoutesName.gameDetailsScreen,
          extra: heroId,
        );
      },
      child: Hero(
        tag: heroId,
        child: AspectRatio(
          aspectRatio: 16 / 9,
          child: Stack(
            children: [
              SizedBox.expand(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 2.0),
                  child: CachedNetworkImage(
                    imageUrl: currentGame.backgroundImage,
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
                          currentGame.name,
                          style: textTheme.headlineLarge,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                        const SizedBox(height: Insets.medium),
                        PlatformsIconRow(
                          platforms: currentGame.platforms,
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
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Swiper(
      // autoplay: true,
      autoplayDelay: 4000,
      itemCount: games.length,
      pagination: _swiperPagination,
      scale: 0.9,
      viewportFraction: 0.98,
      itemBuilder: (context, index) => _swiperItemBuilder(
        context,
        index,
      ),
    );
  }
}
