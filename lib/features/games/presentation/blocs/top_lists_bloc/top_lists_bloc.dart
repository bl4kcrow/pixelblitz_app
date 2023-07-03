import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/utils.dart';
import '../../../domain/domain.dart';

part 'top_lists_event.dart';
part 'top_lists_state.dart';

class TopListsBloc extends Bloc<TopListsEvent, TopListsState> {
  TopListsBloc(this.gamesRepository) : super(const TopListsState()) {
    on<GetInitial>(_onGetInitial);
    on<GetNext>(_onGetNext);
  }

  final GamesRepository gamesRepository;
  late GameTopLists selectedList;
  late DateTime selectedFromDate;
  late DateTime selectedToDate;

  void _onGetInitial(
    GetInitial event,
    Emitter<TopListsState> emit,
  ) async {
    try {
      List<Game> games = [];

      emit(
        state.copyWith(
          requestStatus: GamesRequestStatus.loading,
        ),
      );

      selectedList = event.listType;
      selectedFromDate = event.from;
      selectedToDate = event.to;

      switch (event.listType) {
        case GameTopLists.top:
          games = await gamesRepository.getTop(
            from: event.from,
            to: event.to,
            page: 1,
          );
          break;
        case GameTopLists.popular:
        case GameTopLists.best:
          games = await gamesRepository.getPopular(
            from: event.from,
            to: event.to,
            page: 1,
          );
          break;
        default:
          games = await gamesRepository.getPopular(
            from: event.from,
            to: event.to,
            page: 1,
          );
      }

      if (games.isNotEmpty) {
        emit(
          state.copyWith(
            games: games,
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

  void _onGetNext(
    GetNext event,
    Emitter<TopListsState> emit,
  ) async {
    try {
      List<Game> games = [];

      switch (selectedList) {
        case GameTopLists.top:
          games = await gamesRepository.getTop(
            from: selectedFromDate,
            to: selectedToDate,
            page: event.page,
          );
          break;
        case GameTopLists.popular:
        case GameTopLists.best:
          games = await gamesRepository.getPopular(
            from: selectedFromDate,
            to: selectedToDate,
            page: event.page,
          );
          break;
        default:
          games = await gamesRepository.getPopular(
            from: selectedFromDate,
            to: selectedToDate,
            page: event.page,
          );
      }

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
