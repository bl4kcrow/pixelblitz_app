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
  GameDetailsScreen({
    super.key,
    required this.heroId,
  });

  final String heroId;

  final _pageController = PageController(
    initialPage: 0,
  );

  final ScrollController _viewsScrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);

    return Scaffold(
      body: PopScope(
        onPopInvokedWithResult: (didPop, result) {
          context.read<GameDetailsChipSelectedCubit>().selectChip(0);
        },
        child: BlocBuilder<GameDetailsBloc, GameDetailsState>(
          builder: (context, state) {
            if (state.requestStatus == GamesRequestStatus.success) {
              final GameDetails gameDetails = state.gameDetails;
        
              return NestedScrollView(
                controller: _viewsScrollController,
                physics: const ClampingScrollPhysics(),
                headerSliverBuilder: (context, innerBoxIsScrolled) => [
                  SliverPersistentHeader(
                    pinned: true,
                    delegate: _SliverHeaderDelegate(
                      screenSize: screenSize,
                      gameDetails: gameDetails,
                      heroId: heroId,
                    ),
                  ),
                  SliverPersistentHeader(
                    pinned: true,
                    delegate: _ChipSliverHeaderDelegate(() {
                      _pageController.jumpToPage(
                        context.read<GameDetailsChipSelectedCubit>().state,
                      );
                      _viewsScrollController.animateTo(
                        0.0,
                        duration: const Duration(milliseconds: 30),
                        curve: Curves.bounceIn,
                      );
                    }),
                  ),
                ],
                body: SizedBox(
                  height: screenSize.height * 0.6,
                  child: _GameViews(
                    gameDetails: gameDetails,
                    pageController: _pageController,
                    viewsScrollController: _viewsScrollController,
                  ),
                ),
              );
            } else {
              return const Center(
                child: SpinnerIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}

class _GameViews extends StatefulWidget {
  const _GameViews({
    required this.gameDetails,
    required this.pageController,
    required this.viewsScrollController,
  });

  final GameDetails gameDetails;
  final PageController pageController;
  final ScrollController viewsScrollController;

  @override
  State<_GameViews> createState() => _GameViewsState();
}

class _GameViewsState extends State<_GameViews> {
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
          Text(
            widget.gameDetails.descriptionRaw,
            semanticsLabel:
                '${SemanticLabels.description} ${widget.gameDetails.descriptionRaw}',
          ),
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
    return SingleChildScrollView(
      child: GameInfoTable(gameDetails: widget.gameDetails),
    );
  }

  @override
  void dispose() {
    widget.pageController.dispose();
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
          const SizedBox(height: Insets.medium),
          Expanded(
            child: PageView(
              controller: widget.pageController,
              onPageChanged: (page) {
                context.read<GameDetailsChipSelectedCubit>().selectChip(page);
                widget.viewsScrollController.animateTo(
                  0.0,
                  duration: const Duration(seconds: 1),
                  curve: Curves.bounceIn,
                );
              },
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
    final screenSize = MediaQuery.sizeOf(context);
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Semantics(
      label: SemanticLabels.gameHeaderDetails,
      child: Hero(
        tag: heroId,
        child: AspectRatio(
          aspectRatio: 16 / 9,
          child: Stack(
            children: [
              SizedBox.expand(
                child: CachedNetworkImage(
                  imageUrl: gameDetails.backgroundImage,
                  fit: BoxFit.cover,
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
                        maxLines: AppConstants.commonMaxLines,
                      ),
                      const SizedBox(height: Insets.medium),
                      Semantics(
                        label: SemanticLabels.platformIcons,
                        child: PlatformsIconRow(
                          color: AppColors.white.withValues(alpha: 0.7),
                          platforms: gameDetails.platforms,
                        ),
                      ),
                      const SizedBox(height: Insets.medium),
                      if (isCompacted == false) ...[
                        Text(
                          developers,
                          style: textTheme.bodyLarge?.copyWith(
                            color: AppColors.white.withValues(alpha: 0.6),
                          ),
                          maxLines: AppConstants.commonMaxLines,
                          overflow: TextOverflow.ellipsis,
                          semanticsLabel:
                              '${SemanticLabels.developers} $developers',
                        ),
                        const SizedBox(height: Insets.small),
                        Text(
                          genres,
                          style: textTheme.bodyMedium?.copyWith(
                            color: AppColors.white.withValues(alpha: 0.4),
                          ),
                          maxLines: AppConstants.commonMaxLines,
                          overflow: TextOverflow.ellipsis,
                          semanticsLabel: '${SemanticLabels.genres} $genres',
                        ),
                        const SizedBox(height: Insets.small),
                      ] else
                        const SizedBox.shrink(),
                    ],
                  ),
                ),
              ),
              Positioned(
                right: Insets.small,
                top: screenSize.height * 0.07,
                child: gameDetails.metacritic != null
                    ? CircleAvatar(
                        backgroundColor: MetacriticScore.getFromValue(
                          gameDetails.metacritic!,
                        ).color,
                        radius: 22,
                        child: CircleAvatar(
                          backgroundColor: AppColors.eerieBlack,
                          radius: 20,
                          child: Text(
                            gameDetails.metacritic.toString(),
                            style: textTheme.titleLarge?.copyWith(
                              color: MetacriticScore.getFromValue(
                                gameDetails.metacritic!,
                              ).color,
                            ),
                            semanticsLabel:
                                '${SemanticLabels.metracriticRate} gameDetails.metacritic.toString()',
                          ),
                        ),
                      )
                    : CircleAvatar(
                        backgroundColor: AppColors.eerieBlack,
                        radius: 22,
                        child: CircleAvatar(
                          backgroundColor: AppColors.maroon,
                          radius: 20,
                          child: Text(
                            Labels.questionMark,
                            style: textTheme.titleLarge,
                            semanticsLabel:
                                '${SemanticLabels.metracriticRate} ${Labels.notApplicable}',
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
}

class _ChipSliverHeaderDelegate extends SliverPersistentHeaderDelegate {
  _ChipSliverHeaderDelegate(this.onSelected);

  final Function()? onSelected;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Container(
      color: appTheme.colorScheme.surface,
      padding: const EdgeInsets.symmetric(
        horizontal: Insets.medium,
      ),
      child: GameDetailsChoiceChips(
        onSelected: onSelected,
      ),
    );
  }

  @override
  double get maxExtent => 45.0;

  @override
  double get minExtent => 45.0;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      false;
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
