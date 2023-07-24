import '../../domain/domain.dart';

class GamesRepositoryImpl implements GamesRepository {
  GamesRepositoryImpl(
    this.gamesDatasource,
  );

  final GamesDatasource gamesDatasource;

  @override
  Future<GameDetails> getGameDetails({
    required int id,
  }) async {
    return gamesDatasource.getGameDetails(
      id: id,
    );
  }

  @override
  Future<List<GameScreenshot>> getGameScreenshots({
    required int id,
    int page = 1,
  }) async {
    return gamesDatasource.getGameScreenshots(
      id: id,
      page: page,
    );
  }

  @override
  Future<ApiResponse> getGameSeries({
    required int id,
    int page = 1,
  }) async {
    return gamesDatasource.getGameSeries(
      id: id,
      page: page,
    );
  }

  @override
  Future<ApiResponse> getGamesByGenre({
    required List<int> genreIds,
    int page = 1,
  }) {
    return gamesDatasource.getGamesByGenre(
      genreIds: genreIds,
      page: page,
    );
  }

  @override
  Future<ApiResponse> getGamesByPlatform({
    required List<int> platformIds,
    int page = 1,
  }) {
    return gamesDatasource.getGamesByPlatform(
      platformIds: platformIds,
      page: page,
    );
  }

  @override
  Future<ApiResponse> getNewAndTrending({
    int page = 1,
  }) async {
    return gamesDatasource.getNewAndTrending(
      page: page,
    );
  }
  
  @override
  Future<ApiResponse> getPopular({
    required DateTime from,
    required DateTime to,
    int page = 1,
  }) async {
    return gamesDatasource.getPopular(
      from: from,
      to: to,
      page: page,
    );
  }
  
  @override
  Future<ApiResponse> getRecentReleases({
    required DateTime from,
    required DateTime to,
    int page = 1,
  }) async {
    return gamesDatasource.getRecentReleases(
      from: from,
      to: to,
      page: page,
    );
  }

  @override
  Future<ApiResponse> getTop({
    required DateTime from,
    required DateTime to,
    int page = 1,
  }) async {
    return gamesDatasource.getTop(
      from: from,
      to: to,
      page: page,
    );
  }

  @override
  Future<ApiResponse> search({
    required String searchQuery,
    int page = 1,
  }) async {
    return gamesDatasource.search(
      searchQuery: searchQuery,
      page: page,
    );
  }
}
