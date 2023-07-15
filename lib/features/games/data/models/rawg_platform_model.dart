import 'dart:convert';

class RawgPlatformModel {
  RawgPlatformModel({
    required this.id,
    required this.name,
    required this.slug,
    this.gamesCount,
  });
  
  final int id;
  final String name;
  final String slug;
  final int? gamesCount;

  RawgPlatformModel copyWith({
    int? id,
    String? name,
    String? slug,
    int? gamesCount,
  }) =>
      RawgPlatformModel(
        id: id ?? this.id,
        name: name ?? this.name,
        slug: slug ?? this.slug,
        gamesCount: gamesCount ?? this.gamesCount,
      );

  factory RawgPlatformModel.fromJson(String str) =>
      RawgPlatformModel.fromMap(json.decode(str));

  factory RawgPlatformModel.fromMap(Map<String, dynamic> json) =>
      RawgPlatformModel(
        id: json['id'],
        name: json['name'],
        slug: json['slug'],
        gamesCount: json['games_count'],
      );
}
