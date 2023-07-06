import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/utils.dart';
import '../../../domain/domain.dart';

part 'game_details_event.dart';
part 'game_details_state.dart';

class GameDetailsBloc extends Bloc<GameDetailsEvent, GameDetailsState> {
  GameDetailsBloc(this.gamesRepository)
      : super(GameDetailsState(gameDetails: GameDetails.empty())) {
    on<GetDetails>(_onGetDetails);
  }

  final GamesRepository gamesRepository;

  void _onGetDetails(
    GetDetails event,
    Emitter<GameDetailsState> emit,
  ) async {
    try {
      emit(
        state.copyWith(
          requestStatus: GamesRequestStatus.loading,
        ),
      );

      final details = await gamesRepository.getGameDetails(id: event.id);

      emit(
        state.copyWith(
          gameDetails: details,
          requestStatus: GamesRequestStatus.success,
        ),
      );
    } catch (error) {
      debugPrint(error.toString());
      emit(
        state.copyWith(
          requestStatus: GamesRequestStatus.error,
        ),
      );
    }
  }
}
