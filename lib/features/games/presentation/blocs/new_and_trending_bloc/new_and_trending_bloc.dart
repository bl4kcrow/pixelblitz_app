import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

import '../../../../../core/utils/utils.dart';
import '../../../domain/domain.dart';

part 'new_and_trending_event.dart';
part 'new_and_trending_state.dart';

class NewAndTrendingBloc
    extends Bloc<NewAndTrendingEvent, NewAndTrendingState> {
  NewAndTrendingBloc(this.gamesRepository)
      : super(const NewAndTrendingState()) {
    on<GetNewAndTrending>(_onGetAndTrending);
  }

  final GamesRepository gamesRepository;

  void _onGetAndTrending(
    GetNewAndTrending event,
    Emitter<NewAndTrendingState> emit,
  ) async {
    try {
      final games = await gamesRepository.getNewAndTrending(
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
