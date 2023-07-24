import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/utils.dart';
import '../../../domain/domain.dart';

part 'search_games_event.dart';
part 'search_games_state.dart';

class SearchGamesBloc extends Bloc<SearchGamesEvent, SearchGamesState> {
  SearchGamesBloc(this.gamesRepository) : super(const SearchGamesState()) {
    on<GetInitialSearchGames>(_onGetInitialSearchGames);
    on<GetNextSearchGames>(_onGetNextSearchGames);
  }

  final GamesRepository gamesRepository;

  String currentSearchQuery = '';
  int currentPage = 0;
  bool haveNext = false;

  void _onGetInitialSearchGames(
    GetInitialSearchGames event,
    Emitter<SearchGamesState> emit,
  ) async {
    try {
      List<Game> games = [];

      emit(
        state.copyWith(
          requestStatus: GamesRequestStatus.loading,
        ),
      );

      currentPage = 1;
      currentSearchQuery = event.searchQuery;

      if (currentSearchQuery.isNotEmpty) {
        final ApiResponse response = await gamesRepository.search(
          page: currentPage,
          searchQuery: currentSearchQuery,
        );

        games = response.results as List<Game>;
        haveNext = response.next != null;
      }

      emit(
        state.copyWith(
          games: games,
          requestStatus: GamesRequestStatus.success,
        ),
      );
    } catch (error) {
      currentPage--;
      debugPrint(error.toString());
      emit(
        state.copyWith(requestStatus: GamesRequestStatus.error),
      );
    }
  }

  void _onGetNextSearchGames(
    GetNextSearchGames event,
    Emitter<SearchGamesState> emit,
  ) async {
    try {
      List<Game> games = [];

      currentPage++;

      final ApiResponse response = await gamesRepository.search(
        page: currentPage,
        searchQuery: currentSearchQuery,
      );

      games = response.results as List<Game>;
      haveNext = response.next != null;

      if (games.isNotEmpty) {
        emit(
          state.copyWith(
            games: [...state.games, ...games],
            requestStatus: GamesRequestStatus.success,
          ),
        );
      }
    } catch (error) {
      currentPage--;
      debugPrint(error.toString());
      emit(
        state.copyWith(requestStatus: GamesRequestStatus.error),
      );
    }
  }
}
