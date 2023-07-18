part of 'games_by_genre_bloc.dart';

class GamesByGenreState extends Equatable {
  const GamesByGenreState({
    this.games = const [],
    this.requestStatus = GamesRequestStatus.initial,
  });

  final List<Game> games;
  final GamesRequestStatus requestStatus;

  GamesByGenreState copyWith({
    List<Game>? games,
    GamesRequestStatus? requestStatus,
  }) =>
      GamesByGenreState(
        games: games ?? this.games,
        requestStatus: requestStatus ?? this.requestStatus,
      );

  @override
  List<Object?> get props => [
        games,
        requestStatus,
      ];
}
