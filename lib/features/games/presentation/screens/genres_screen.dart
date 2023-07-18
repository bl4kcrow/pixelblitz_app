import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theme/theme.dart';
import '../../../../core/utils/utils.dart';
import '../presentation.dart';

class GenresScreen extends StatefulWidget {
  const GenresScreen({super.key});

  @override
  State<GenresScreen> createState() => _GenresScreenState();
}

class _GenresScreenState extends State<GenresScreen> {
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    context.read<GenresBloc>().add(GetInitialGenres());
    context
        .read<GamesByGenreBloc>()
        .add(GetInitialGamesByGenre(genresIds: const []));
    scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    if (scrollController.offset >= scrollController.position.maxScrollExtent &&
        !scrollController.position.outOfRange) {
      if (context.read<GamesByGenreBloc>().haveNext) {
        context.read<GamesByGenreBloc>().add(GetNextGamesByGenre());
      }
    }
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Genres'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: Insets.medium),
        child: Column(
          children: [
            SizedBox(
              height: screenSize.width * 0.5,
              child: const HorizontalGenresGridList(),
            ),
            Expanded(
              child: BlocBuilder<GamesByGenreBloc, GamesByGenreState>(
                builder: (context, state) {
                  if (state.requestStatus == GamesRequestStatus.success) {
                    return GamesList(
                      games: state.games,
                      listController: scrollController,
                    );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator.adaptive(),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
