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
}
