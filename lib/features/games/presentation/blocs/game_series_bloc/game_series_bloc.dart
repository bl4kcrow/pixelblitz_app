import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/utils.dart';
import '../../../domain/domain.dart';

part 'game_series_event.dart';
part 'game_series_state.dart';

class GameSeriesBloc extends Bloc<GameSeriesEvent, GameSeriesState> {
  GameSeriesBloc(this.gamesRepository) : super(const GameSeriesState()) {
    on<GetInitialGameSeries>(_onGetInitialGameSeries);
    on<GetNextGameSeries>(_onGetNextGameSeries);
  }

  final GamesRepository gamesRepository;

  int currentPage = 0;
  int gameId = 0;
  bool haveNext = false;

  void _onGetInitialGameSeries(
    GetInitialGameSeries event,
    Emitter<GameSeriesState> emit,
  ) async {
    try {
      List<Game> games = [];

      emit(
        state.copyWith(
          requestStatus: GamesRequestStatus.loading,
        ),
      );

      currentPage = 1;
      gameId = event.id;

      final ApiResponse response = await gamesRepository.getGameSeries(
        id: event.id,
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

  void _onGetNextGameSeries(
    GetNextGameSeries event,
    Emitter<GameSeriesState> emit,
  ) async {
    try {
      List<Game> games = [];

      currentPage++;

      final ApiResponse response = await gamesRepository.getGameSeries(
        id: gameId,
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
