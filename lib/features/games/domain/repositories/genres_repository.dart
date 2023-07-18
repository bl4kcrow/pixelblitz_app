import '../domain.dart';

abstract class GenresRepository {
  Future<ApiResponse> getGenres({
    int page = 1,
  });
}
