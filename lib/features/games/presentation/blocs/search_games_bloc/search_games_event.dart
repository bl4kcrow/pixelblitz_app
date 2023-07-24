part of 'search_games_bloc.dart';

@immutable
abstract class SearchGamesEvent {}

class GetInitialSearchGames extends SearchGamesEvent {
  GetInitialSearchGames({
    required this.searchQuery,
  });

  final String searchQuery;
}

class GetNextSearchGames extends SearchGamesEvent {}
