import '../domain.dart';

abstract class GamesRepository {
  Future<List<Game>> getNewAndTrending({
    int page = 1,
  });

  Future<List<Game>> getPopular({
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
