import '../../../../core/constants/constants.dart';
import '../domain.dart';

class GameDetails {
  final int id;
  final String slug;
  final String name;
  final String descriptionRaw;
  final int? metacritic;
  final String? metacriticUrl;
  final DateTime? released;
  final bool tba;
  final String backgroundImage;
  final String? website;
  final double rating;
  final List<Platform> platforms;
  final List<Developer> developers;
  final List<Publisher> publishers;
  final List<Genre> genres;
  final List<Store>? stores;
  final List<Tag> tags;
  final String? esrbRating;

  GameDetails({
    required this.id,
    required this.slug,
    required this.name,
    required this.descriptionRaw,
    this.metacritic,
    this.metacriticUrl,
    this.released,
    required this.tba,
    required this.backgroundImage,
    this.website,
    required this.rating,
    required this.platforms,
    required this.developers,
    required this.publishers,
    required this.genres,
    this.stores,
    required this.tags,
    this.esrbRating,
  });

  GameDetails copyWith({
    int? id,
    String? slug,
    String? name,
    String? descriptionRaw,
    int? metacritic,
    String? metacriticUrl,
    DateTime? released,
    bool? tba,
    String? backgroundImage,
    String? website,
    double? rating,
    List<Platform>? platforms,
    List<Developer>? developers,
    List<Publisher>? publishers,
    List<Genre>? genres,
    List<Store>? stores,
    List<Tag>? tags,
    String? esrbRating,
  }) =>
      GameDetails(
        id: id ?? this.id,
        slug: slug ?? this.slug,
        name: name ?? this.name,
        descriptionRaw: descriptionRaw ?? this.descriptionRaw,
        metacritic: metacritic ?? this.metacritic,
        metacriticUrl: metacriticUrl ?? this.metacriticUrl,
        released: released ?? this.released,
        tba: tba ?? this.tba,
        backgroundImage: backgroundImage ?? this.backgroundImage,
        website: website ?? this.website,
        rating: rating ?? this.rating,
        platforms: platforms ?? this.platforms,
        developers: developers ?? this.developers,
        publishers: publishers ?? this.publishers,
        genres: genres ?? this.genres,
        stores: stores ?? this.stores,
        tags: tags ?? this.tags,
        esrbRating: esrbRating ?? this.esrbRating,
      );

  factory GameDetails.empty() => GameDetails(
        id: 0,
        slug: Labels.notApplicable,
        name: Labels.notApplicable,
        descriptionRaw: Labels.notApplicable,
        tba: false,
        backgroundImage: Labels.notApplicable,
        rating: 0.0,
        platforms: [],
        developers: [],
        publishers: [],
        genres: [],
        tags: [],
      );
}
