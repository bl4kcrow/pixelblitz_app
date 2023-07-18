import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/utils.dart';
import '../../../domain/domain.dart';

part 'games_by_genre_event.dart';
part 'games_by_genre_state.dart';

class GamesByGenreBloc extends Bloc<GamesByGenreEvent, GamesByGenreState> {
  GamesByGenreBloc(this.gamesRepository) : super(const GamesByGenreState()) {
    on<GetInitialGamesByGenre>(_onGetInitialGamesByGenre);
    on<GetNextGamesByGenre>(_onGetNextGamesByGenre);
  }

  final GamesRepository gamesRepository;

  int currentPage = 0;
  List<int> genreIds = [];
  bool haveNext = false;

  void _onGetInitialGamesByGenre(
    GetInitialGamesByGenre event,
    Emitter<GamesByGenreState> emit,
  ) async {
    try {
      List<Game> games = [];

      emit(
        state.copyWith(
          requestStatus: GamesRequestStatus.loading,
        ),
      );

      currentPage = 1;
      genreIds = event.genresIds;

      final ApiResponse response = await gamesRepository.getGamesByGenre(
        genreIds: event.genresIds,
        page: currentPage,
      );

      games = response.results as List<Game>;
      haveNext = response.next != null;

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

  void _onGetNextGamesByGenre(
    GetNextGamesByGenre event,
    Emitter<GamesByGenreState> emit,
  ) async {
    try {
      List<Game> games = [];

      currentPage++;

      final ApiResponse response = await gamesRepository.getGamesByGenre(
        genreIds: genreIds,
        page: currentPage,
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
