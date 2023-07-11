part of 'game_series_bloc.dart';

class GameSeriesState extends Equatable {
  const GameSeriesState({
    this.games = const [],
    this.requestStatus = GamesRequestStatus.initial,
  });

  final List<Game> games;
  final GamesRequestStatus requestStatus;

  GameSeriesState copyWith({
    List<Game>? games,
    GamesRequestStatus? requestStatus,
  }) =>
      GameSeriesState(
        games: games ?? this.games,
        requestStatus: requestStatus ?? this.requestStatus,
      );

  @override
  List<Object?> get props => [
        games,
        requestStatus,
      ];
}
