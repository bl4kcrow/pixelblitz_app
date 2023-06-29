import '../domain.dart';

class Game {
  final int id;
  final String slug;
  final String name;
  final DateTime released;
  final bool tba;
  final String backgroundImage;
  final double rating;
  final int ratingTop;
  final int ratingsCount;
  final int reviewsTextCount;
  final int added;
  final int? metacritic;
  final int playtime;
  final int suggestionsCount;
  final DateTime updated;
  final int reviewsCount;
  final String saturatedColor;
  final String dominantColor;
  final List<Platform> platforms;
  final List<Genre> genres;
  final List<Store>? stores;
  final List<Tag> tags;
  final String? esrbRating;
  final List<String> shortScreenshots;

  Game({
    required this.id,
    required this.slug,
    required this.name,
    required this.released,
    required this.tba,
    required this.backgroundImage,
    required this.rating,
    required this.ratingTop,
    required this.ratingsCount,
    required this.reviewsTextCount,
    required this.added,
    this.metacritic,
    required this.playtime,
    required this.suggestionsCount,
    required this.updated,
    required this.reviewsCount,
    required this.saturatedColor,
    required this.dominantColor,
    required this.platforms,
    required this.genres,
    required this.stores,
    required this.tags,
    required this.esrbRating,
    required this.shortScreenshots,
  });

  Game copyWith({
    int? id,
    String? slug,
    String? name,
    DateTime? released,
    bool? tba,
    String? backgroundImage,
    double? rating,
    int? ratingTop,
    int? ratingsCount,
    int? reviewsTextCount,
    int? added,
    int? metacritic,
    int? playtime,
    int? suggestionsCount,
    DateTime? updated,
    int? reviewsCount,
    String? saturatedColor,
    String? dominantColor,
    List<Platform>? platforms,
    List<Genre>? genres,
    List<Store>? stores,
    List<Tag>? tags,
    String? esrbRating,
    List<String>? shortScreenshots,
  }) =>
      Game(
        id: id ?? this.id,
        slug: slug ?? this.slug,
        name: name ?? this.name,
        released: released ?? this.released,
        tba: tba ?? this.tba,
        backgroundImage: backgroundImage ?? this.backgroundImage,
        rating: rating ?? this.rating,
        ratingTop: ratingTop ?? this.ratingTop,
        ratingsCount: ratingsCount ?? this.ratingsCount,
        reviewsTextCount: reviewsTextCount ?? this.reviewsTextCount,
        added: added ?? this.added,
        metacritic: metacritic ?? this.metacritic,
        playtime: playtime ?? this.playtime,
        suggestionsCount: suggestionsCount ?? this.suggestionsCount,
        updated: updated ?? this.updated,
        reviewsCount: reviewsCount ?? this.reviewsCount,
        saturatedColor: saturatedColor ?? this.saturatedColor,
        dominantColor: dominantColor ?? this.dominantColor,
        platforms: platforms ?? this.platforms,
        genres: genres ?? this.genres,
        stores: stores ?? this.stores,
        tags: tags ?? this.tags,
        esrbRating: esrbRating ?? this.esrbRating,
        shortScreenshots: shortScreenshots ?? this.shortScreenshots,
      );
}
