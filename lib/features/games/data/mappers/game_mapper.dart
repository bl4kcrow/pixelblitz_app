import '../../domain/domain.dart';
import '../data.dart';

class GameMapper {
  static Game rawgGameToEntity(RawgGameModel rawgGame) => Game(
        id: rawgGame.id,
        slug: rawgGame.slug,
        name: rawgGame.name,
        released: rawgGame.released,
        tba: rawgGame.tba,
        backgroundImage: rawgGame.backgroundImage,
        rating: rawgGame.rating,
        ratingTop: rawgGame.ratingTop,
        ratingsCount: rawgGame.ratingsCount,
        reviewsTextCount: rawgGame.reviewsTextCount,
        added: rawgGame.added,
        playtime: rawgGame.playtime,
        suggestionsCount: rawgGame.suggestionsCount,
        updated: rawgGame.updated,
        reviewsCount: rawgGame.reviewsCount,
        saturatedColor: rawgGame.saturatedColor,
        dominantColor: rawgGame.dominantColor,
        platforms: rawgGame.platforms
            .map(
              (rawgPlatform) => Platform(
                id: rawgPlatform.id,
                name: rawgPlatform.name,
                slug: rawgPlatform.slug,
                gamesCount: rawgPlatform.gamesCount,
                imageBackground: rawgPlatform.imageBackground,
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
        shortScreenshots: rawgGame.shortScreenshots,
      );
}
