part of 'games_by_platform_bloc.dart';

class GamesByPlatformState extends Equatable {
  const GamesByPlatformState({
    this.games = const [],
    this.requestStatus = GamesRequestStatus.initial,
  });

  final List<Game> games;
  final GamesRequestStatus requestStatus;

  GamesByPlatformState copyWith({
    List<Game>? games,
    GamesRequestStatus? requestStatus,
  }) =>
      GamesByPlatformState(
        games: games ?? this.games,
        requestStatus: requestStatus ?? this.requestStatus,
      );

  @override
  List<Object?> get props => [
        games,
        requestStatus,
      ];
}
