import 'dart:convert';

class RawgDeveloperModel {
  RawgDeveloperModel({
    required this.id,
    required this.name,
    required this.slug,
    this.gamesCount,
  });

  final int id;
  final String name;
  final String slug;
  final int? gamesCount;

  RawgDeveloperModel copyWith({
    int? id,
    String? name,
    String? slug,
    int? gamesCount,
    String? imageBackground,
  }) =>
      RawgDeveloperModel(
        id: id ?? this.id,
        name: name ?? this.name,
        slug: slug ?? this.slug,
        gamesCount: gamesCount ?? this.gamesCount,
      );

  factory RawgDeveloperModel.fromJson(String str) =>
      RawgDeveloperModel.fromMap(json.decode(str));

  factory RawgDeveloperModel.fromMap(Map<String, dynamic> json) =>
      RawgDeveloperModel(
        id: json['id'],
        name: json['name'],
        slug: json['slug'],
        gamesCount: json['games_count'],
      );
}
