part of 'genres_bloc.dart';

class GenresState extends Equatable {
  const GenresState({
    this.genres = const [],
    this.requestStatus = GamesRequestStatus.initial,
  });

  final List<Genre> genres;
  final GamesRequestStatus requestStatus;

  GenresState copyWith({
    List<Genre>? genres,
    GamesRequestStatus? requestStatus,
  }) =>
      GenresState(
        genres: genres ?? this.genres,
        requestStatus: requestStatus ?? this.requestStatus,
      );

  @override
  List<Object?> get props => [
        genres,
        requestStatus,
      ];
}
