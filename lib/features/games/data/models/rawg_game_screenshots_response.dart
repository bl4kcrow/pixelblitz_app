import '../data.dart';

class RawgGameScreenshotsResponse {
  RawgGameScreenshotsResponse({
    required this.count,
    required this.next,
    required this.previous,
    required this.results,
  });

  final int count;
  final String? next;
  final String? previous;
  final List<RawgGameScreenshotModel> results;

  factory RawgGameScreenshotsResponse.fromJson(Map<String, dynamic> json) =>
      RawgGameScreenshotsResponse(
        count: json['count'],
        next: json['next'],
        previous: json['previous'],
        results: List<RawgGameScreenshotModel>.from(
          json['results'].map((rawgGame) {
            return RawgGameScreenshotModel.fromMap(rawgGame);
          }),
        ),
      );
}
