part of 'popular_bloc.dart';

class PopularState extends Equatable {
  const PopularState({
    this.games = const [],
    this.requestStatus = GamesRequestStatus.initial,
  });

  final List<Game> games;
  final GamesRequestStatus requestStatus;

  PopularState copyWith({
    List<Game>? games,
    GamesRequestStatus? requestStatus,
  }) =>
      PopularState(
        games: games ?? this.games,
        requestStatus: requestStatus ?? this.requestStatus,
      );

  @override
  List<Object?> get props => [
        games,
        requestStatus,
      ];
}
