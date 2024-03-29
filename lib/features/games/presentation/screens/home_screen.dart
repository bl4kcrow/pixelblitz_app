import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/theme/theme.dart';
import '../../../../core/utils/utils.dart';
import '../presentation.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _TopSwiper(),
          const SizedBox(height: Insets.medium),
          const _CenterSegmentedButton(),
          const SizedBox(height: Insets.medium),
          Expanded(child: _BottomGridCards()),
        ],
      ),
    );
  }
}

class _BottomGridCards extends StatefulWidget {
  @override
  State<_BottomGridCards> createState() => _BottomGridCardsState();
}

class _BottomGridCardsState extends State<_BottomGridCards> {
  final DateTime fromDate = DateTime.now().copyWith(
    month: 01,
    day: 01,
  );

  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    if (scrollController.offset >= scrollController.position.maxScrollExtent &&
        !scrollController.position.outOfRange) {
      if (context.read<TopListsBloc>().haveNext) {
        context.read<TopListsBloc>().add(GetNext());
      }
    }
  }

  Widget _shimmerBody() {
    return GridView(
      padding: const EdgeInsets.all(Insets.xsmall),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        childAspectRatio: 16 / 9,
        crossAxisCount: 2,
        mainAxisSpacing: Insets.medium,
        crossAxisSpacing: Insets.small,
      ),
      children: [
        for (int item = 1; item <= 8; item++) ...[
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppRadius.small),
              color: AppColors.eerieBlack,
            ),
          ),
        ],
      ],
    );
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: Insets.medium),
      child: BlocBuilder<TopListsBloc, TopListsState>(
        builder: (context, state) {
          FlutterNativeSplash.remove();
          if (state.requestStatus == GamesRequestStatus.success) {
            return GridCards(
              games: state.games,
              scrollController: scrollController,
            );
          } else {
            return AppShimmer(
              child: _shimmerBody(),
            );
          }
        },
      ),
    );
  }
}

class _CenterSegmentedButton extends StatelessWidget {
  const _CenterSegmentedButton();

  Widget _emptyBody() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Insets.medium),
      child: Container(
        height: 40,
        width: double.maxFinite,
        decoration: const BoxDecoration(color: AppColors.eerieBlack),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TopListsBloc, TopListsState>(
      builder: (context, state) {
        if (state.requestStatus == GamesRequestStatus.success) {
          return const SegmentedListsButton();
        } else {
          return _emptyBody();
        }
      },
      buildWhen: (_, current) =>
          current.requestStatus == GamesRequestStatus.success,
    );
  }
}

class _TopSwiper extends StatelessWidget {
  Widget _shimmerBody(Size screenSize) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: Insets.medium,
        vertical: Insets.large,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: Insets.medium,
            ),
            height: 30.0,
            width: screenSize.width * 0.8,
            decoration: const BoxDecoration(color: AppColors.eerieBlack),
          ),
          const SizedBox(height: Insets.small),
          Container(
            height: 10.0,
            width: screenSize.width * 0.3,
            decoration: const BoxDecoration(color: AppColors.eerieBlack),
          ),
          const SizedBox(height: Insets.small),
          Container(
            height: 10.0,
            width: screenSize.width * 0.5,
            decoration: const BoxDecoration(color: AppColors.eerieBlack),
          ),
          const SizedBox(height: Insets.small),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);

    return BlocBuilder<NewAndTrendingBloc, NewAndTrendingState>(
      builder: (context, state) {
        return SizedBox(
          height: screenSize.height * 0.4,
          width: double.maxFinite,
          child: state.requestStatus == GamesRequestStatus.success
              ? Stack(
                  children: [
                    CardSwiper(
                      games: state.games,
                    ),
                    Positioned(
                      right: Insets.medium,
                      top: screenSize.height * 0.07,
                      child: Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: AppColors.white.withOpacity(0.8),
                            radius: 20,
                            child: IconButton(
                              onPressed: () {
                                showSearch(
                                  query: context
                                      .read<SearchGamesBloc>()
                                      .currentSearchQuery,
                                  context: context,
                                  delegate: GamesSearchDelegate(),
                                  useRootNavigator: true,
                                );
                              },
                              icon: const FaIcon(
                                FontAwesomeIcons.magnifyingGlass,
                                color: AppColors.black,
                                size: IconSize.medium,
                                semanticLabel: SemanticLabels.searchButton,
                              ),
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (_) => const InfoALertDialog(),
                              );
                            },
                            icon: FaIcon(
                              FontAwesomeIcons.circleInfo,
                              color: AppColors.white.withOpacity(0.8),
                              size: IconSize.large,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              : AppShimmer(
                  child: _shimmerBody(screenSize),
                ),
        );
      },
    );
  }
}
