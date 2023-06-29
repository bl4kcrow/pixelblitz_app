import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/utils.dart';
import '../../../domain/domain.dart';

part 'popular_event.dart';
part 'popular_state.dart';

class PopularBloc extends Bloc<PopularEvent, PopularState> {
  PopularBloc(this.gamesRepository) : super(const PopularState()) {
    on<GetInitialPopular>(_onGetInitialPopular);
    on<GetNextPopular>(_onGetNextPopular);
  }

  final GamesRepository gamesRepository;

  void _onGetInitialPopular(
    GetInitialPopular event,
    Emitter<PopularState> emit,
  ) async {
    try {
      final games = await gamesRepository.getPopular(
        from: event.from,
        to: event.to,
        page: 1,
      );

      if (games.isNotEmpty) {
        emit(
          state.copyWith(
            games: [...state.games, ...games],
            requestStatus: GamesRequestStatus.success,
          ),
        );
      }
    } catch (error) {
      debugPrint(error.toString());
      emit(
        state.copyWith(requestStatus: GamesRequestStatus.error),
      );
    }
  }

  void _onGetNextPopular(
    GetNextPopular event,
    Emitter<PopularState> emit,
  ) async {
    try {
      final games = await gamesRepository.getPopular(
        from: event.from,
        to: event.to,
        page: event.page,
      );

      if (games.isNotEmpty) {
        emit(
          state.copyWith(
            games: [...state.games, ...games],
            requestStatus: GamesRequestStatus.success,
          ),
        );
      }
    } catch (error) {
      debugPrint(error.toString());
      emit(
        state.copyWith(requestStatus: GamesRequestStatus.error),
      );
    }
  }
}
