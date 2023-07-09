import 'package:dio/dio.dart';
import 'package:intl/intl.dart';

import '../../../../core/constants/constants.dart';
import '../../domain/domain.dart';
import '../data.dart';

class RawgGamesDatasource implements GamesDatasource {
  final int pageSize = 15;
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
  Future<List<Game>> getNewAndTrending({
    int page = 1,
  }) async {
    final List<Game> games = [];

    final response = await _dio.get(
      '/games/lists/main',
      queryParameters: {
        'discover': true,
        'ordering': '-relevance',
        'page': page,
        'page_size': pageSize,
      },
    );

    final rawgGamesList = RawgGamesListResponse.fromJson(response.data).results;

    games.addAll(
      rawgGamesList.map(
        (rawgGame) => GameMapper.rawgGameToEntity(rawgGame),
      ),
    );

    return games;
  }

  @override
  Future<List<Game>> getPopular({
    int page = 1,
    required DateTime from,
    required DateTime to,
  }) async {
    final List<Game> games = [];

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

    final rawgGamesList = RawgGamesListResponse.fromJson(response.data).results;

    games.addAll(
      rawgGamesList.map(
        (rawgGame) => GameMapper.rawgGameToEntity(rawgGame),
      ),
    );

    return games;
  }

  @override
  Future<List<Game>> getRecentReleases({
    required DateTime from,
    required DateTime to,
    int page = 1,
  }) async {
    final List<Game> games = [];

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

    final rawgGamesList = RawgGamesListResponse.fromJson(response.data).results;

    games.addAll(
      rawgGamesList.map(
        (rawgGame) => GameMapper.rawgGameToEntity(rawgGame),
      ),
    );

    return games;
  }

  @override
  Future<List<Game>> getTop({
    required DateTime from,
    required DateTime to,
    int page = 1,
  }) async {
    final List<Game> games = [];

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

    final rawgGamesList = RawgGamesListResponse.fromJson(response.data).results;

    games.addAll(
      rawgGamesList.map(
        (rawgGame) => GameMapper.rawgGameToEntity(rawgGame),
      ),
    );

    return games;
  }
}
