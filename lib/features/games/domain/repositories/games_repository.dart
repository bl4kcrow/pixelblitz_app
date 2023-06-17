import '../domain.dart';

abstract class GamesRepository {
  Future<List<Game>> getNewAndTrending({
    int page = 1,
  });
}
