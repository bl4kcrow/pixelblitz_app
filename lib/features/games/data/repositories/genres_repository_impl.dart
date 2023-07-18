import '../../domain/domain.dart';

class GenresRepositoryImpl implements GenresRepository {
  GenresRepositoryImpl(
    this.genresDatasource,
  );

  final GenresDatasource genresDatasource;

  @override
  Future<ApiResponse> getGenres({int page = 1}) async {
    return genresDatasource.getGenres(page: page);
  }
}
