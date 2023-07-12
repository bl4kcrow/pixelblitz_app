import 'package:pixelblitz_app/core/constants/constants.dart';
import 'package:pixelblitz_app/core/theme/theme.dart';

import '../domain.dart';

class GameDetails {
  final int id;
  final String slug;
  final String name;
  final String description;
  final String descriptionRaw;
  final int? metacritic;
  final String? metacriticUrl;
  final DateTime? released;
  final bool tba;
  final String backgroundImage;
  final String? backgroundImageAdditional;
  final String? website;
  final double rating;
  final String saturatedColor;
  final String dominantColor;
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
    required this.description,
    required this.descriptionRaw,
    this.metacritic,
    this.metacriticUrl,
    this.released,
    required this.tba,
    required this.backgroundImage,
    this.backgroundImageAdditional,
    this.website,
    required this.rating,
    required this.saturatedColor,
    required this.dominantColor,
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
    String? description,
    String? descriptionRaw,
    int? metacritic,
    String? metacriticUrl,
    DateTime? released,
    bool? tba,
    String? backgroundImage,
    String? backgroundImageAdditional,
    String? website,
    double? rating,
    String? saturatedColor,
    String? dominantColor,
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
        description: description ?? this.description,
        descriptionRaw: descriptionRaw ?? this.descriptionRaw,
        metacritic: metacritic ?? this.metacritic,
        metacriticUrl: metacriticUrl ?? this.metacriticUrl,
        released: released ?? this.released,
        tba: tba ?? this.tba,
        backgroundImage: backgroundImage ?? this.backgroundImage,
        backgroundImageAdditional:
            backgroundImageAdditional ?? this.backgroundImageAdditional,
        website: website ?? this.website,
        rating: rating ?? this.rating,
        saturatedColor: saturatedColor ?? this.saturatedColor,
        dominantColor: dominantColor ?? this.dominantColor,
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
        description: Labels.notApplicable,
        descriptionRaw: Labels.notApplicable,
        tba: false,
        backgroundImage: Labels.notApplicable,
        rating: 0.0,
        saturatedColor: AppColors.maroon.value.toString(),
        dominantColor: AppColors.eerieBlack.value.toString(),
        platforms: [],
        developers: [],
        publishers: [],
        genres: [],
        tags: [],
      );
}
