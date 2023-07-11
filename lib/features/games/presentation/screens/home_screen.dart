import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
          const SegmentedListsButton(),
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
              borderRadius: BorderRadius.circular(10.0),
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
              ? CardSwiper(
                  games: state.games,
                )
              : AppShimmer(
                  child: _shimmerBody(screenSize),
                ),
        );
      },
    );
  }
}
