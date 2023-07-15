import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/utils.dart';
import '../../../domain/domain.dart';

part 'platforms_event.dart';
part 'platforms_state.dart';

class PlatformsBloc extends Bloc<PlatformsEvent, PlatformsState> {
  PlatformsBloc(this.platformsRepository) : super(const PlatformsState()) {
    on<GetInitialPlatforms>(_onGetInitialPlatforms);
    on<GetNextPlatforms>(_onGetNextPlatforms);
  }

  final PlatformsRepository platformsRepository;

  int currentPage = 0;
  bool haveNext = false;

  void _onGetInitialPlatforms(
    GetInitialPlatforms event,
    Emitter<PlatformsState> emit,
  ) async {
    try {
      List<Platform> platforms = [];

      emit(
        state.copyWith(
          requestStatus: GamesRequestStatus.loading,
        ),
      );

      currentPage = 1;

      final ApiResponse response = await platformsRepository.getPlatforms(
        page: currentPage,
      );

      platforms = response.results as List<Platform>;
      haveNext = response.next != null;

      emit(
        state.copyWith(
          platforms: platforms,
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

  void _onGetNextPlatforms(
    GetNextPlatforms event,
    Emitter<PlatformsState> emit,
  ) async {
    try {
      List<Platform> platforms = [];

      currentPage++;

      final ApiResponse response = await platformsRepository.getPlatforms(
        page: currentPage,
      );

      platforms = response.results as List<Platform>;
      haveNext = response.next != null;

      if (platforms.isNotEmpty) {
        emit(
          state.copyWith(
            platforms: [...state.platforms, ...platforms],
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
