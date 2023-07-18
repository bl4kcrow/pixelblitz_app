part of 'games_by_genre_bloc.dart';

@immutable
abstract class GamesByGenreEvent {}

class GetInitialGamesByGenre extends GamesByGenreEvent {
  GetInitialGamesByGenre({
    required this.genresIds,
  });

  final List<int> genresIds;
}

class GetNextGamesByGenre extends GamesByGenreEvent {}
