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
}
