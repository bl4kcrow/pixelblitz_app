import '../../domain/domain.dart';

class PlatformsRepositoryImpl implements PlatformsRepository {
  PlatformsRepositoryImpl(
    this.platformsDatasource,
  );

  final PlatformsDatasource platformsDatasource;

  @override
  Future<ApiResponse> getPlatforms({int page = 1}) async {
    return platformsDatasource.getPlatforms(page: page);
  }
}
