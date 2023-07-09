import '../data.dart';

class RawgGamesListResponse {
  RawgGamesListResponse({
    required this.count,
    this.next,
    this.previous,
    required this.results,
  });

  final int count;
  final String? next;
  final String? previous;
  final List<RawgGameModel> results;

  factory RawgGamesListResponse.fromJson(Map<String, dynamic> json) =>
      RawgGamesListResponse(
        count: json['count'],
        next: json['next'],
        previous: json['previous'],
        results: List<RawgGameModel>.from(
          json['results'].map((rawgGame) {
            return RawgGameModel.fromMap(rawgGame);
          }),
        ),
      );
}
