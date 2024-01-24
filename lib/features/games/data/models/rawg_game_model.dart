import 'dart:convert';

import '../../../../core/constants/constants.dart';
import '../data.dart';

class RawgGameModel {
  final int id;
  final String name;
  final DateTime? released;
  final String backgroundImage;
  final double rating;
  final int? metacritic;
  final List<RawgPlatformModel> platforms;
  final List<RawgGenreModel> genres;

  RawgGameModel({
    required this.id,
    required this.name,
    this.released,
    required this.backgroundImage,
    required this.rating,
    this.metacritic,
    required this.platforms,
    required this.genres,
  });

  RawgGameModel copyWith({
    int? id,
    String? name,
    DateTime? released,
    String? backgroundImage,
    double? rating,
    int? metacritic,
    List<RawgPlatformModel>? platforms,
    List<RawgGenreModel>? genres,
  }) =>
      RawgGameModel(
        id: id ?? this.id,
        name: name ?? this.name,
        released: released ?? this.released,
        backgroundImage: backgroundImage ?? this.backgroundImage,
        rating: rating ?? this.rating,
        metacritic: metacritic ?? this.metacritic,
        platforms: platforms ?? this.platforms,
        genres: genres ?? this.genres,
      );

  factory RawgGameModel.fromJson(String str) =>
      RawgGameModel.fromMap(json.decode(str));

  factory RawgGameModel.fromMap(Map<String, dynamic> json) {
    return RawgGameModel(
      id: json['id'],
      name: json['name'],
      released:
          json['released'] != null ? DateTime.tryParse(json['released']) : null,
      backgroundImage: json['background_image'] ?? AppConstants.noImageUrl,
      rating: json['rating']?.toDouble(),
      metacritic: json['metacritic']?.toInt(),
      platforms: json['platforms'] != null
          ? List<RawgPlatformModel>.from(
              json['platforms'].map(
                (platforms) => RawgPlatformModel.fromMap(platforms['platform']),
              ),
            )
          : [
              RawgPlatformModel(
                id: 0,
                name: Labels.notApplicable,
                slug: Labels.notApplicable,
              )
            ],
      genres: json['genres'] != null
          ? List<RawgGenreModel>.from(
              json['genres'].map(
                (genre) => RawgGenreModel.fromMap(genre),
              ),
            )
          : [
              RawgGenreModel(
                id: 0,
                name: Labels.notApplicable,
                slug: Labels.notApplicable,
              )
            ],
    );
  }
}
