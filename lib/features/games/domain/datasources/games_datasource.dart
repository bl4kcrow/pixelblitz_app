import '../domain.dart';

abstract class GamesDatasource {
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
}
