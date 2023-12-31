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

  late GameTopLists selectedList;
  late DateTime selectedFromDate;
  late DateTime selectedToDate;

  final GamesRepository gamesRepository;

  int currentPage = 0;
  bool haveNext = false;

  void _onGetInitial(
    GetInitial event,
    Emitter<TopListsState> emit,
  ) async {
    try {
      late final ApiResponse response;

      List<Game> games = [];

      emit(
        state.copyWith(
          requestStatus: GamesRequestStatus.loading,
        ),
      );

      selectedList = event.listType;
      selectedFromDate = event.from;
      selectedToDate = event.to;
      currentPage = 1;

      switch (event.listType) {
        case GameTopLists.top:
          response = await gamesRepository.getTop(
            from: event.from,
            to: event.to,
            page: currentPage,
          );
          break;
        case GameTopLists.recentReleases:
          response = await gamesRepository.getRecentReleases(
            from: event.from,
            to: event.to,
            page: currentPage,
          );
          break;
        case GameTopLists.popular:
        case GameTopLists.best:
          response = await gamesRepository.getPopular(
            from: event.from,
            to: event.to,
            page: currentPage,
          );
          break;
        default:
          response = await gamesRepository.getPopular(
            from: event.from,
            to: event.to,
            page: currentPage,
          );
      }

      games = response.results as List<Game>;
      haveNext = response.next != null;

      if (games.isNotEmpty) {
        emit(
          state.copyWith(
            games: games,
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

  void _onGetNext(
    GetNext event,
    Emitter<TopListsState> emit,
  ) async {
    try {
      late final ApiResponse response;

      List<Game> games = [];

      currentPage++;
      switch (selectedList) {
        case GameTopLists.top:
          response = await gamesRepository.getTop(
            from: selectedFromDate,
            to: selectedToDate,
            page: currentPage,
          );
          break;
        case GameTopLists.popular:
        case GameTopLists.best:
          response = await gamesRepository.getPopular(
            from: selectedFromDate,
            to: selectedToDate,
            page: currentPage,
          );
          break;
        default:
          response = await gamesRepository.getPopular(
            from: selectedFromDate,
            to: selectedToDate,
            page: currentPage,
          );
      }

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
