import 'package:dio/dio.dart';

import '../../../../core/constants/constants.dart';
import '../../domain/domain.dart';
import '../data.dart';

class RawgGamesDatasource implements GamesDatasource {
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
