part of 'top_lists_bloc.dart';

class TopListsState extends Equatable {
  const TopListsState({
    this.games = const [],
    this.requestStatus = GamesRequestStatus.initial,
  });

  final List<Game> games;
  final GamesRequestStatus requestStatus;

  TopListsState copyWith({
    List<Game>? games,
    GamesRequestStatus? requestStatus,
  }) =>
      TopListsState(
        games: games ?? this.games,
        requestStatus: requestStatus ?? this.requestStatus,
      );

  @override
  List<Object?> get props => [
        games,
        requestStatus,
      ];
}
