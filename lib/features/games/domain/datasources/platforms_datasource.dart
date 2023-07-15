import '../domain.dart';

abstract class PlatformsDatasource {
  Future<ApiResponse> getPlatforms({
    int page = 1,
  });
}
