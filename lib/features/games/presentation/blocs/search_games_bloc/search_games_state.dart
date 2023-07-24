part of 'search_games_bloc.dart';

class SearchGamesState extends Equatable {
  const SearchGamesState({
    this.games = const [],
    this.requestStatus = GamesRequestStatus.initial,
  });

  final List<Game> games;
  final GamesRequestStatus requestStatus;

  SearchGamesState copyWith({
    List<Game>? games,
    GamesRequestStatus? requestStatus,
  }) =>
      SearchGamesState(
        games: games ?? this.games,
        requestStatus: requestStatus ?? this.requestStatus,
      );

  @override
  List<Object> get props => [
        games,
        requestStatus,
      ];
}
