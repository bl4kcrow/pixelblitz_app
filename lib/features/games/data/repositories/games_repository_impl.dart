import '../../domain/domain.dart';

class GamesRepositoryImpl implements GamesRepository {
  GamesRepositoryImpl(
    this.gamesDatasource,
  );

  final GamesDatasource gamesDatasource;

  @override
  Future<List<Game>> getNewAndTrending({int page = 1}) async {
    return gamesDatasource.getNewAndTrending(page: page);
  }
  
  @override
  Future<List<Game>> getPopular({
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
}
