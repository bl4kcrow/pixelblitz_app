import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/utils/utils.dart';
import '../presentation.dart';

class GamesSearchDelegate extends SearchDelegate {
  GamesSearchDelegate() : super(searchFieldLabel: Labels.searchGames);

  Timer? _debounceTimer;

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () => query = '',
        icon: const FaIcon(FontAwesomeIcons.xmark),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        _debounceTimer?.cancel();
        close(context, null);
      },
      icon: const FaIcon(FontAwesomeIcons.chevronLeft),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return _SearchResultsList(
      voidCallback: () {
        _debounceTimer?.cancel();
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query == '' ||
        query != context.read<SearchGamesBloc>().currentSearchQuery) {
      if (_debounceTimer?.isActive == true) {
        _debounceTimer?.cancel();
      }

      _debounceTimer = Timer(
        const Duration(milliseconds: 1000),
        () {
          context.read<SearchGamesBloc>().add(
                GetInitialSearchGames(searchQuery: query),
              );
        },
      );
    }

    return _SearchResultsList(
      voidCallback: () {
        _debounceTimer?.cancel();
      },
    );
  }
}

class _SearchResultsList extends StatefulWidget {
  const _SearchResultsList({
    this.voidCallback,
  });

  final VoidCallback? voidCallback;

  @override
  State<_SearchResultsList> createState() => __SearchResultsListState();
}

class __SearchResultsListState extends State<_SearchResultsList> {
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    if (scrollController.offset >= scrollController.position.maxScrollExtent &&
        !scrollController.position.outOfRange) {
      if (context.read<SearchGamesBloc>().haveNext) {
        context.read<SearchGamesBloc>().add(GetNextSearchGames());
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
    return BlocBuilder<SearchGamesBloc, SearchGamesState>(
      builder: (context, state) {
        if (state.requestStatus == GamesRequestStatus.success ||
            state.requestStatus == GamesRequestStatus.initial) {
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
    );
  }
}
