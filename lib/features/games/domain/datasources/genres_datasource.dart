import '../domain.dart';

abstract class GenresDatasource {
  Future<ApiResponse> getGenres({
    int page = 1,
  });
}
