part of 'new_and_trending_bloc.dart';

class NewAndTrendingState extends Equatable {
  const NewAndTrendingState({
    this.games = const [],
    this.requestStatus = GamesRequestStatus.initial,
  });

  final List<Game> games;
  final GamesRequestStatus requestStatus;

  NewAndTrendingState copyWith({
    List<Game>? games,
    GamesRequestStatus? requestStatus,
  }) =>
      NewAndTrendingState(
        games: games ?? this.games,
        requestStatus: requestStatus ?? this.requestStatus,
      );

  @override
  List<Object?> get props => [
        games,
        requestStatus,
      ];
}
