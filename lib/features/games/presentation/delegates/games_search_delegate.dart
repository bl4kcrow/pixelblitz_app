import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../core/constants/constants.dart';
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
    return GamesSearchResultList(
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

    return GamesSearchResultList(
      voidCallback: () {
        _debounceTimer?.cancel();
      },
    );
  }
}

