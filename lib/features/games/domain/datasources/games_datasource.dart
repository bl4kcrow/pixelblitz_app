import '../domain.dart';

abstract class GamesDatasource {
  Future<List<Game>> getNewAndTrending({
    int page = 1,
  });
}
