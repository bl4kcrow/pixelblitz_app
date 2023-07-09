import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/utils.dart';
import '../../../domain/domain.dart';

part 'game_screenshots_event.dart';
part 'game_screenshots_state.dart';

class GameScreenshotsBloc
    extends Bloc<GameScreenshotsEvent, GameScreenshotsState> {
  GameScreenshotsBloc(this.gamesRepository)
      : super(const GameScreenshotsState()) {
    on<GetInitialScreenshots>(_onGetInitialScreenshots);
    on<GetNextScreenshots>(_onGetNextScreenshots);
  }

  final GamesRepository gamesRepository;

  int currentPage = 0;
  int gameId = 0;

  void _onGetInitialScreenshots(
    GetInitialScreenshots event,
    Emitter<GameScreenshotsState> emit,
  ) async {
    try {
      List<GameScreenshot> screenshots = [];

      emit(
        state.copyWith(
          requestStatus: GamesRequestStatus.loading,
        ),
      );

      currentPage = 1;
      gameId = event.id;

      screenshots = await gamesRepository.getGameScreenshots(
        id: event.id,
        page: currentPage,
      );

      if (screenshots.isNotEmpty) {
        emit(
          state.copyWith(
            gameScreenshots: screenshots,
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

  void _onGetNextScreenshots(
    GetNextScreenshots event,
    Emitter<GameScreenshotsState> emit,
  ) async {
    try {
      List<GameScreenshot> screenshots = [];

      emit(
        state.copyWith(
          requestStatus: GamesRequestStatus.loading,
        ),
      );

      currentPage++;

      screenshots = await gamesRepository.getGameScreenshots(
        id: gameId,
        page: currentPage,
      );

      if (screenshots.isNotEmpty) {
        emit(
          state.copyWith(
            gameScreenshots: screenshots,
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
