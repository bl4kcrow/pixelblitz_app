import '../domain.dart';

abstract class GamesRepository {
  Future<GameDetails> getGameDetails({
    required int id,
  });
  
  Future<List<GameScreenshot>> getGameScreenshots({
    required int id,
    int page = 1,
  });

  Future<ApiResponse> getGameSeries({
    required int id,
    int page = 1,
  });

  Future<ApiResponse> getGamesByGenre({
    required List<int> genreIds,
    int page = 1,
  });

  Future<ApiResponse> getGamesByPlatform({
    required List<int> platformIds,
    int page = 1,
  });
  
  Future<ApiResponse> getNewAndTrending({
    int page = 1,
  });

  Future<ApiResponse> getPopular({
    required DateTime from,
    required DateTime to,
    int page = 1,
  });

  Future<ApiResponse> getRecentReleases({
    required DateTime from,
    required DateTime to,
    int page = 1,
  });

  Future<ApiResponse> getTop({
    required DateTime from,
    required DateTime to,
    int page = 1,
  });

  Future<ApiResponse> search({
    required String searchQuery,
    int page = 1,
  });
}
