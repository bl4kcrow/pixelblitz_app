import 'dart:convert';

import '../data.dart';

class RawgGameModel {
  final int id;
  final String name;
  final DateTime released;
  final String backgroundImage;
  final double rating;
  final int? metacritic;
  final List<RawgPlatformModel> platforms;
  final List<RawgGenreModel> genres;

  RawgGameModel({
    required this.id,
    required this.name,
    required this.released,
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

  factory RawgGameModel.fromMap(Map<String, dynamic> json) => RawgGameModel(
        id: json['id'],
        name: json['name'],
        released: DateTime.parse(json['released']),
        backgroundImage: json['background_image'] ??
            'https://icon-library.com/images/no-picture-available-icon/no-picture-available-icon-1.jpg',
        rating: json['rating']?.toDouble(),
        metacritic: json['metacritic'],
        platforms: List<RawgPlatformModel>.from(
          json['platforms']
              .map((platform) => RawgPlatformModel.fromMap(platform)),
        ),
        genres: List<RawgGenreModel>.from(
          json['genres'].map((genre) => RawgGenreModel.fromMap(genre)),
        ),
      );
}
