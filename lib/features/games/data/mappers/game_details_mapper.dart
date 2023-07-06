import '../../domain/domain.dart';
import '../data.dart';

class GameDetailsMapper {
  static GameDetails rawgGameToEntity(RawgGameDetailsModel rawgGame) =>
      GameDetails(
        id: rawgGame.id,
        slug: rawgGame.slug,
        name: rawgGame.name,
        description: rawgGame.description,
        descriptionRaw: rawgGame.descriptionRaw,
        metacritic: rawgGame.metacritic,
        metacriticUrl: rawgGame.metacriticUrl,
        released: rawgGame.released,
        tba: rawgGame.tba,
        backgroundImage: rawgGame.backgroundImage,
        backgroundImageAdditional: rawgGame.backgroundImageAdditional,
        website: rawgGame.website,
        rating: rawgGame.rating,
        saturatedColor: rawgGame.saturatedColor,
        dominantColor: rawgGame.dominantColor,
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
        developers: rawgGame.developers
            .map(
              (rawgDeveloper) => Developer(
                id: rawgDeveloper.id,
                name: rawgDeveloper.name,
                slug: rawgDeveloper.slug,
                gamesCount: rawgDeveloper.gamesCount,
              ),
            )
            .toList(),
        publishers: rawgGame.publishers
            .map(
              (rawgPublisher) => Publisher(
                id: rawgPublisher.id,
                name: rawgPublisher.name,
                slug: rawgPublisher.slug,
                gamesCount: rawgPublisher.gamesCount,
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
        stores: rawgGame.stores
            ?.map(
              (rawgStore) => Store(
                id: rawgStore.id,
                name: rawgStore.name,
                slug: rawgStore.slug,
              ),
            )
            .toList(),
        tags: rawgGame.tags
            .map(
              (rawgTag) => Tag(
                id: rawgTag.id,
                name: rawgTag.name,
                slug: rawgTag.slug,
              ),
            )
            .toList(),
        esrbRating: rawgGame.esrbRating,
      );
}
