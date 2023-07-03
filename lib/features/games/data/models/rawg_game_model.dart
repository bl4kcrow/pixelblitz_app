import 'dart:convert';

import '../data.dart';

class RawgGameModel {
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
  final List<RawgPlatformModel> platforms;
  final List<RawgGenreModel> genres;
  final List<RawgStoreModel>? stores;
  final List<RawgTagModel> tags;
  final String? esrbRating;
  final List<String> shortScreenshots;

  RawgGameModel({
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
    this.stores,
    required this.tags,
    this.esrbRating,
    required this.shortScreenshots,
  });

  RawgGameModel copyWith({
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
    List<RawgPlatformModel>? platforms,
    List<RawgGenreModel>? genres,
    List<RawgStoreModel>? stores,
    List<RawgTagModel>? tags,
    String? esrbRating,
    List<String>? shortScreenshots,
  }) =>
      RawgGameModel(
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

  factory RawgGameModel.fromJson(String str) =>
      RawgGameModel.fromMap(json.decode(str));

  factory RawgGameModel.fromMap(Map<String, dynamic> json) => RawgGameModel(
        id: json['id'],
        slug: json['slug'],
        name: json['name'],
        released: DateTime.parse(json['released']),
        tba: json['tba'],
        backgroundImage: json['background_image'],
        rating: json['rating']?.toDouble(),
        ratingTop: json['rating_top'],
        ratingsCount: json['ratings_count'],
        reviewsTextCount: json['reviews_text_count'],
        added: json['added'],
        metacritic: json['metacritic'],
        playtime: json['playtime'],
        suggestionsCount: json['suggestions_count'],
        updated: DateTime.parse(json['updated']),
        reviewsCount: json['reviews_count'],
        saturatedColor: json['saturated_color'],
        dominantColor: json['dominant_color'],
        platforms: List<RawgPlatformModel>.from(
          json['platforms']
              .map((platform) => RawgPlatformModel.fromMap(platform)),
        ),
        genres: List<RawgGenreModel>.from(
          json['genres'].map((genre) => RawgGenreModel.fromMap(genre)),
        ),
        stores: json['stores'] != null
            ? List<RawgStoreModel>.from(
                json['stores'].map((store) => RawgStoreModel.fromMap(store)),
              )
            : null,
        tags: List<RawgTagModel>.from(
          json['tags'].map((tag) => RawgTagModel.fromMap(tag)),
        ),
        esrbRating:
            (json['esrb_rating'] != null) ? json['esrb_rating']['name'] : null,
        shortScreenshots: List<String>.from(
          json['short_screenshots']
              .map((shortScreenshot) => shortScreenshot['image']),
        ),
      );
}
