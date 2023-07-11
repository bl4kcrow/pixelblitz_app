import '../../domain/domain.dart';
import '../data.dart';

class GameMapper {
  static Game rawgGameToEntity(RawgGameModel rawgGame) => Game(
        id: rawgGame.id,
        name: rawgGame.name,
        released: rawgGame.released,
        backgroundImage: rawgGame.backgroundImage,
        rating: rawgGame.rating,
        metacritic: rawgGame.metacritic,
        platforms: rawgGame.platforms
            .map(
              (rawgPlatform) => Platform(
                id: rawgPlatform.id,
                name: rawgPlatform.name,
                slug: rawgPlatform.slug,
                gamesCount: rawgPlatform.gamesCount,
              ),
            )
            .toList(),
        genres: rawgGame.genres
            .map(
              (rawgGenre) => Genre(
                id: rawgGenre.id,
                name: rawgGenre.name,
                slug: rawgGenre.slug,
              ),
            )
            .toList(),
      );
}
