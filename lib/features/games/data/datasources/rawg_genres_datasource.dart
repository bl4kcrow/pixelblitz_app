import 'package:dio/dio.dart';

import '../../../../core/constants/constants.dart';
import '../../domain/domain.dart';
import '../data.dart';

class RawgGenresDatasource implements GenresDatasource {
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
  Future<ApiResponse> getGenres({
    int page = 1,
  }) async {
    final response = await _dio.get(
      '/genres',
      queryParameters: {
        'ordering': 'name',
        'page': page,
        'page_size': pageSize,
      },
    );

    return RawgGenresResponse.fromJson(response.data);
  }
}
