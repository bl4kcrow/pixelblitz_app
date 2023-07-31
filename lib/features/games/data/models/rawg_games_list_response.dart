import '../../domain/domain.dart';
import '../data.dart';

class RawgGamesListResponse extends ApiResponse<List<Game>> {
  RawgGamesListResponse({
    required super.count,
    super.next,
    super.previous,
    required super.results,
  });

  factory RawgGamesListResponse.fromJson(Map<String, dynamic> json) =>
      RawgGamesListResponse(
        count: json['count'] ?? 0,
        next: json['next'],
        previous: json['previous'],
        results: List<Game>.from(
          json['results'].map((rawgGame) {
              return GameMapper.rawgGameToEntity(
                RawgGameModel.fromMap(
                  rawgGame,
                ),
              );
            },
          ),
        ),
      );
}
