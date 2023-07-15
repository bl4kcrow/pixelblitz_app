import 'package:dio/dio.dart';
import 'package:pixelblitz_app/features/games/data/models/rawg_platforms_response.dart';

import '../../../../core/constants/constants.dart';
import '../../domain/domain.dart';

class RawgPlatformsDatasource implements PlatformsDatasource {
  final int pageSize = 20;
  final _dio = Dio(
    BaseOptions(
      baseUrl: 'https://api.rawg.io/api',
      queryParameters: {
        'key': Environment.rawgApiKey,
      },
    ),
  );

  @override
  Future<ApiResponse> getPlatforms({
    int page = 1,
  }) async {
    final response = await _dio.get(
      '/platforms',
      queryParameters: {
        'page': page,
        'page_size': pageSize,
      },
    );

    return RawgPlatformsResponse.fromJson(response.data);
  }
}
