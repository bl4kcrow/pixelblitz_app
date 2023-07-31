import '../../domain/domain.dart';
import '../data.dart';

class RawgGenresResponse extends ApiResponse<List<Genre>> {
  RawgGenresResponse({
    required super.count,
    super.next,
    super.previous,
    required super.results,
  });

  factory RawgGenresResponse.fromJson(Map<String, dynamic> json) =>
      RawgGenresResponse(
        count: json['count'] ?? 0,
        next: json['next'],
        previous: json['previous'],
        results: List<Genre>.from(
          json['results'].map(
            (rawgGenre) {
              return GenreMapper.rawgGenreToEntity(
                RawgGenreModel.fromMap(
                  rawgGenre,
                ),
              );
            },
          ),
        ),
      );
}
