import '../domain.dart';

abstract class GamesDatasource {
  Future<GameDetails> getGameDetails({
    required int id,
  });

  Future<List<GameScreenshot>> getGameScreenshots({
    required int id,
    int page = 1,
  });
  
  Future<List<Game>> getNewAndTrending({
    int page = 1,
  });

  Future<List<Game>> getPopular({
    required DateTime from,
    required DateTime to,
    int page = 1,
  });

  Future<List<Game>> getRecentReleases({
    required DateTime from,
    required DateTime to,
    int page = 1,
  });

  Future<List<Game>> getTop({
    required DateTime from,
    required DateTime to,
    int page = 1,
  });
}
