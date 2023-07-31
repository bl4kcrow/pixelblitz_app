import '../../domain/domain.dart';
import '../data.dart';

class RawgPlatformsResponse extends ApiResponse<List<Platform>> {
  RawgPlatformsResponse({
    required super.count,
    super.next,
    super.previous,
    required super.results,
  });

  factory RawgPlatformsResponse.fromJson(Map<String, dynamic> json) =>
      RawgPlatformsResponse(
        count: json['count'] ?? 0,
        next: json['next'],
        previous: json['previous'],
        results: List<Platform>.from(
          json['results'].map(
            (rawgPlatform) {
              return PlatformMapper.rawgPlatformToEntity(
                RawgPlatformModel.fromMap(
                  rawgPlatform,
                ),
              );
            },
          ),
        ),
      );
}
