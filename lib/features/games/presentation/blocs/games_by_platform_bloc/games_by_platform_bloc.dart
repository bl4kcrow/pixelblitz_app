import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/utils.dart';
import '../../../domain/domain.dart';

part 'games_by_platform_event.dart';
part 'games_by_platform_state.dart';

class GamesByPlatformBloc
    extends Bloc<GamesByPlatformEvent, GamesByPlatformState> {
  GamesByPlatformBloc(this.gamesRepository)
      : super(const GamesByPlatformState()) {
    on<GetInitialGamesByPlatform>(_onGetInitialGamesByPlatform);
    on<GetNextGamesByPlatform>(_onGetNextGamesByPlatform);
  }

  final GamesRepository gamesRepository;

  int currentPage = 0;
  List<int> platformsIds = [];
  bool haveNext = false;

  void _onGetInitialGamesByPlatform(
    GetInitialGamesByPlatform event,
    Emitter<GamesByPlatformState> emit,
  ) async {
    try {
      List<Game> games = [];

      emit(
        state.copyWith(
          requestStatus: GamesRequestStatus.loading,
        ),
      );

      currentPage = 1;
      platformsIds = event.platformIds;

      final ApiResponse response = await gamesRepository.getGamesByPlatform(
        platformIds: event.platformIds,
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

  void _onGetNextGamesByPlatform(
    GetNextGamesByPlatform event,
    Emitter<GamesByPlatformState> emit,
  ) async {
    try {
      List<Game> games = [];

      currentPage++;

      final ApiResponse response = await gamesRepository.getGamesByPlatform(
        platformIds: platformsIds,
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
