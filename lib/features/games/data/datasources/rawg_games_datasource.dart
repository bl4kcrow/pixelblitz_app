import 'package:dio/dio.dart';
import 'package:intl/intl.dart';

import '../../../../core/constants/constants.dart';
import '../../domain/domain.dart';
import '../data.dart';

class RawgGamesDatasource implements GamesDatasource {
  final int pageSize = 16;
  final _dio = Dio(
    BaseOptions(
      baseUrl: 'https://api.rawg.io/api',
      queryParameters: {
        'key': Environment.rawgApiKey,
      },
    ),
  );

  @override
  Future<GameDetails> getGameDetails({
    required int id,
  }) async {
    final response = await _dio.get(
      '/games/$id',
    );

    final rawgGameDetails = RawgGameDetailsModel.fromMap(response.data);

    return GameDetailsMapper.rawgGameToEntity(rawgGameDetails);
  }

  @override
  Future<List<GameScreenshot>> getGameScreenshots({
    required int id,
    int page = 1,
  }) async {
    final List<GameScreenshot> screenshots = [];

    final response = await _dio.get(
      '/games/$id/screenshots',
      queryParameters: {
        'page': page,
        'page_size': pageSize,
      },
    );

    final rawgGameScreenshots =
        RawgGameScreenshotsResponse.fromJson(response.data).results;

    screenshots.addAll(
      rawgGameScreenshots.map(
        (rawgGameScreenshot) =>
            GameScreenshotMapper.rawgGameScreenshotToEntity(rawgGameScreenshot),
      ),
    );

    return screenshots;
  }

  @override
  Future<ApiResponse> getGameSeries({
    required int id,
    int page = 1,
  }) async {

    final response = await _dio.get(
      '/games/$id/game-series',
      queryParameters: {
        'page': page,
        'page_size': pageSize,
      },
    );

    return RawgGamesListResponse.fromJson(response.data);
  }

  @override
  Future<ApiResponse> getGamesByPlatform({
    required List<int> platformIds,
    int page = 1,
  }) async {
    final Map<String, dynamic> queryParameters = {
      'ordering': '-added',
      'page': page,
      'page_size': pageSize,
    };

    if (platformIds.isNotEmpty) {
      final platformsSelected = platformIds.join(', ');
      queryParameters['platforms'] = platformsSelected;
    }

    final response = await _dio.get(
      '/games',
      queryParameters: queryParameters,
    );

    return RawgGamesListResponse.fromJson(response.data);
  }

  @override
  Future<ApiResponse> getNewAndTrending({
    int page = 1,
  }) async {
    final response = await _dio.get(
      '/games/lists/main',
      queryParameters: {
        'discover': true,
        'ordering': '-relevance',
        'page': page,
        'page_size': pageSize,
      },
    );

    return RawgGamesListResponse.fromJson(response.data);
  }

  @override
  Future<ApiResponse> getPopular({
    int page = 1,
    required DateTime from,
    required DateTime to,
  }) async {

    final String dates =
        '${DateFormat('yyyy-MM-dd').format(from)},${DateFormat('yyyy-MM-dd').format(to)}';

    final response = await _dio.get(
      '/games',
      queryParameters: {
        'dates': dates,
        'ordering': '-added',
        'page': page,
        'page_size': pageSize,
      },
    );

    return RawgGamesListResponse.fromJson(response.data);
  }

  @override
  Future<ApiResponse> getRecentReleases({
    required DateTime from,
    required DateTime to,
    int page = 1,
  }) async {

    final String dates =
        '${DateFormat('yyyy-MM-dd').format(from)},${DateFormat('yyyy-MM-dd').format(to)}';

    final response = await _dio.get(
      '/games',
      queryParameters: {
        'dates': dates,
        'ordering': '-added',
        'page': page,
        'page_size': pageSize,
      },
    );

    return RawgGamesListResponse.fromJson(response.data);
  }

  @override
  Future<ApiResponse> getTop({
    required DateTime from,
    required DateTime to,
    int page = 1,
  }) async {

    final String dates =
        '${DateFormat('yyyy-MM-dd').format(from)},${DateFormat('yyyy-MM-dd').format(to)}';

    final response = await _dio.get(
      '/games',
      queryParameters: {
        'dates': dates,
        'ordering': '-rating',
        'page': page,
        'page_size': pageSize,
      },
    );

    return RawgGamesListResponse.fromJson(response.data);
  }
}
