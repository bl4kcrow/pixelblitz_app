part of 'genres_bloc.dart';

@immutable
abstract class GenresEvent {}

class GetInitialGenres extends GenresEvent {}

class GetNextGenres extends GenresEvent {}
