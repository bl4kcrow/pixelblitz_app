import 'dart:convert';

import '../../../../core/constants/constants.dart';
import '../data.dart';

class RawgGameDetailsModel {
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
  final List<RawgPlatformModel> platforms;
  final List<RawgDeveloperModel> developers;
  final List<RawgPublisherModel> publishers;
  final List<RawgGenreModel> genres;
  final List<RawgStoreModel>? stores;
  final List<RawgTagModel> tags;
  final String? esrbRating;

  RawgGameDetailsModel({
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

  RawgGameDetailsModel copyWith({
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
    List<RawgPlatformModel>? platforms,
    List<RawgDeveloperModel>? developers,
    List<RawgPublisherModel>? publishers,
    List<RawgGenreModel>? genres,
    List<RawgStoreModel>? stores,
    List<RawgTagModel>? tags,
    String? esrbRating,
  }) =>
      RawgGameDetailsModel(
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

  factory RawgGameDetailsModel.fromJson(String str) =>
      RawgGameDetailsModel.fromMap(json.decode(str));

  factory RawgGameDetailsModel.fromMap(Map<String, dynamic> json) {
    return RawgGameDetailsModel(
      id: json['id'],
      slug: json['slug'],
      name: json['name'],
      descriptionRaw: json['description_raw'],
      metacritic: json['metacritic'],
      metacriticUrl: json['metacritic_url'],
      released:
          json['released'] != null ? DateTime.tryParse(json['released']) : null,
      tba: json['tba'],
      backgroundImage: json['background_image'] ?? AppConstants.noImageUrl,
      website: json['website'],
      rating: json['rating']?.toDouble(),
      platforms: List<RawgPlatformModel>.from(
        json['platforms']
            .map(
            (platforms) => RawgPlatformModel.fromMap(platforms['platform'])),
      ),
      developers: List<RawgDeveloperModel>.from(
        json['developers']
            .map((developer) => RawgDeveloperModel.fromMap(developer)),
      ),
      publishers: List<RawgPublisherModel>.from(
        json['publishers']
            .map((publisher) => RawgPublisherModel.fromMap(publisher)),
      ),
      genres: List<RawgGenreModel>.from(
        json['genres'].map((genre) => RawgGenreModel.fromMap(genre)),
      ),
      stores: List<RawgStoreModel>.from(
        json['stores'].map((store) => RawgStoreModel.fromMap(store)),
      ),
      tags: List<RawgTagModel>.from(
        json['tags'].map((tag) => RawgTagModel.fromMap(tag)),
      ),
      esrbRating:
          json['esrb_rating'] != null ? json['esrb_rating']['name'] : null,
    );
  }
}
