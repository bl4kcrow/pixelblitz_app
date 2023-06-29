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

  int currentPage = 1;
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    if (scrollController.offset >= scrollController.position.maxScrollExtent &&
        !scrollController.position.outOfRange) {
      debugPrint('NEXTLOAD');
      currentPage++;
      context.read<PopularBloc>().add(
            GetNextPopular(
              from: fromDate,
              to: DateTime.now(),
              page: currentPage,
            ),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: Insets.medium),
      child: BlocBuilder<PopularBloc, PopularState>(
        builder: (context, state) {
          if (state.requestStatus == GamesRequestStatus.success) {
            return GridCards(
              games: state.games,
              scrollController: scrollController,
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

class _TopSwiper extends StatelessWidget {
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
              : const Center(
                  child: CircularProgressIndicator.adaptive(),
                ),
        );
      },
    );
  }
}
