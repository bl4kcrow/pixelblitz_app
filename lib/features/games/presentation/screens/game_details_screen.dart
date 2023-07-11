import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/theme/theme.dart';
import '../../../../core/utils/utils.dart';
import '../../domain/domain.dart';
import '../presentation.dart';

class GameDetailsScreen extends StatelessWidget {
  const GameDetailsScreen({
    super.key,
    required this.heroId,
  });

  final String heroId;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);

    return Scaffold(
      body: BlocBuilder<GameDetailsBloc, GameDetailsState>(
        builder: (context, state) {
          if (state.requestStatus == GamesRequestStatus.success) {
            final GameDetails gameDetails = state.gameDetails;

            return CustomScrollView(
              physics: const ClampingScrollPhysics(),
              slivers: [
                SliverPersistentHeader(
                  pinned: true,
                  delegate: _SliverHeaderDelegate(
                    screenSize: screenSize,
                    gameDetails: gameDetails,
                    heroId: heroId,
                  ),
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) => SizedBox(
                      height: screenSize.height * 0.6,
                      child: _GameViews(
                        gameDetails: gameDetails,
                      ),
                    ),
                    childCount: 1,
                  ),
                ),
              ],
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

class _GameViews extends StatefulWidget {
  const _GameViews({
    required this.gameDetails,
  });

  final GameDetails gameDetails;

  @override
  State<_GameViews> createState() => _GameViewsState();
}

class _GameViewsState extends State<_GameViews> {
  final List<String> _chips = [
    Labels.about,
    Labels.info,
    Labels.gameSeries,
  ];
  final _pageController = PageController(
    initialPage: 0,
  );

  int _chipSelected = 0;

  @override
  void initState() {
    super.initState();
  }

  Widget _aboutView() {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(widget.gameDetails.descriptionRaw),
          const SizedBox(height: Insets.large),
          Text(
            Labels.snapshots,
            style: textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(height: Insets.medium),
          const HorizontalGameScreenshotsView(),
        ],
      ),
    );
  }

  Widget _gameSeriesView() {
    return const GameSeriesList();
  }

  Widget _infoView() {
    return Text(widget.gameDetails.website);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: Insets.medium,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              for (int index = 0; index < _chips.length; index++) ...[
                ChoiceChip(
                  label: Text(_chips[index]),
                  selected: _chipSelected == index,
                  onSelected: (_) {
                    setState(() {
                      _chipSelected = index;
                    });
                    _pageController.jumpToPage(
                      _chipSelected,
                    );
                  },
                ),
                const SizedBox(width: Insets.small),
              ],
            ],
          ),
          const SizedBox(height: Insets.medium),
          Expanded(
            child: PageView(
              controller: _pageController,
              onPageChanged: (page) => setState(() {
                _chipSelected = page;
              }),
              children: [
                _aboutView(),
                _infoView(),
                _gameSeriesView(),
              ],
            ),
          ),
          const SizedBox(height: Insets.small),
        ],
      ),
    );
  }
}

class _GameCard extends StatelessWidget {
  const _GameCard({
    required this.heroId,
    required this.gameDetails,
    this.isCompacted = false,
  });

  final String heroId;
  final GameDetails gameDetails;
  final bool isCompacted;

  @override
  Widget build(BuildContext context) {
    final String developers = gameDetails.developers.join(', ');
    final String genres = gameDetails.genres.join(', ');
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Hero(
      tag: heroId,
      child: AspectRatio(
        aspectRatio: 16 / 9,
        child: Stack(
          children: [
            SizedBox.expand(
              child: CachedNetworkImage(
                imageUrl: gameDetails.backgroundImage,
                fit: BoxFit.cover,
                memCacheHeight: 2160,
                memCacheWidth: 3840,
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
                      0.6,
                      1.0,
                    ],
                  ),
                ),
              ),
            ),
            Positioned.fill(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: Insets.medium,
                  vertical: Insets.medium,
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
                      color: AppColors.white.withOpacity(0.7),
                      platforms: gameDetails.platforms,
                    ),
                    const SizedBox(height: Insets.medium),
                    if (isCompacted == false) ...[
                      Text(
                        developers,
                        style: textTheme.bodyLarge?.copyWith(
                          color: AppColors.white.withOpacity(0.6),
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: Insets.small),
                      Text(
                        genres,
                        style: textTheme.bodyMedium?.copyWith(
                          color: AppColors.white.withOpacity(0.4),
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: Insets.small),
                    ] else
                      const SizedBox.shrink(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SliverHeaderDelegate extends SliverPersistentHeaderDelegate {
  _SliverHeaderDelegate({
    required this.heroId,
    required this.gameDetails,
    required this.screenSize,
  });

  final String heroId;
  final GameDetails gameDetails;
  final Size screenSize;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Stack(
      children: [
        Positioned.fill(
          child: _GameCard(
            heroId: heroId,
            gameDetails: gameDetails,
            isCompacted: shrinkOffset > maxExtent - minExtent,
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
    );
  }

  @override
  double get maxExtent => screenSize.height * 0.6;

  @override
  double get minExtent => screenSize.height * 0.3;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      false;
}
