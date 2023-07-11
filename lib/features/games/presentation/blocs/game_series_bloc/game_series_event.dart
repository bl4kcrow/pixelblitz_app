part of 'game_series_bloc.dart';

@immutable
abstract class GameSeriesEvent {}

class GetInitialGameSeries extends GameSeriesEvent {
  GetInitialGameSeries({
    required this.id,
  });

  final int id;
}

class GetNextGameSeries extends GameSeriesEvent {}
