import '../domain.dart';

abstract class PlatformsRepository {
  Future<ApiResponse> getPlatforms({
    int page = 1,
  });
}
