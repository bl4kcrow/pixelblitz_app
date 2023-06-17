import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

import '../../../domain/domain.dart';

part 'games_event.dart';
part 'games_state.dart';

class GamesBloc extends Bloc<GamesEvent, GamesState> {
  GamesBloc(this.gamesRepository) : super(const GamesState()) {
    on<GetNewAndTrending>(
      (event, emit) async {
        try {
          final games = await gamesRepository.getNewAndTrending(
            page: currentPage,
          );

          if (games.isNotEmpty) {
            emit(
              state.copyWith(
                games: [...state.games, ...games],
                requestStatus: GamesRequestStatus.success,
              ),
            );

            currentPage++;
          }
        } catch (error) {
          debugPrint(error.toString());
          emit(
            state.copyWith(requestStatus: GamesRequestStatus.error),
          );
        }
      },
    );
  }

  final GamesRepository gamesRepository;
  int currentPage = 1;
}
