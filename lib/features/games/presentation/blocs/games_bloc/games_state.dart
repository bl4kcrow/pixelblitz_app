part of 'games_bloc.dart';

enum GamesRequestStatus {
  initial,
  success,
  error,
  loading,
}

@immutable
class GamesState extends Equatable {
  const GamesState({
    this.games = const [],
    this.requestStatus = GamesRequestStatus.initial,
  });

  final List<Game> games;
  final GamesRequestStatus requestStatus;

  GamesState copyWith({
    List<Game>? games,
    GamesRequestStatus? requestStatus,
  }) =>
      GamesState(
        games: games ?? this.games,
        requestStatus: requestStatus ?? this.requestStatus,
      );

  @override
  List<Object?> get props => [
        games,
        requestStatus,
      ];
}
