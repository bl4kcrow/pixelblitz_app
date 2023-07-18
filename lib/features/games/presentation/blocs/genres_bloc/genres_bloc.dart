import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/utils.dart';
import '../../../domain/domain.dart';

part 'genres_event.dart';
part 'genres_state.dart';

class GenresBloc extends Bloc<GenresEvent, GenresState> {
  GenresBloc(this.genresRepository) : super(const GenresState()) {
    on<GetInitialGenres>(_onGetInitialgenres);
    on<GetNextGenres>(_onGetNextgenres);
  }

  final GenresRepository genresRepository;

  int currentPage = 0;
  bool haveNext = false;

  void _onGetInitialgenres(
    GetInitialGenres event,
    Emitter<GenresState> emit,
  ) async {
    try {
      List<Genre> genres = [];

      emit(
        state.copyWith(
          requestStatus: GamesRequestStatus.loading,
        ),
      );

      currentPage = 1;

      final ApiResponse response = await genresRepository.getGenres(
        page: currentPage,
      );

      genres = response.results as List<Genre>;
      haveNext = response.next != null;

      emit(
        state.copyWith(
          genres: genres,
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

  void _onGetNextgenres(
    GetNextGenres event,
    Emitter<GenresState> emit,
  ) async {
    try {
      List<Genre> genres = [];

      currentPage++;

      final ApiResponse response = await genresRepository.getGenres(
        page: currentPage,
      );

      genres = response.results as List<Genre>;
      haveNext = response.next != null;

      if (genres.isNotEmpty) {
        emit(
          state.copyWith(
            genres: [...state.genres, ...genres],
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
