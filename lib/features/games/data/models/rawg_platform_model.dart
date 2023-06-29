import 'dart:convert';

class RawgPlatformModel {
  RawgPlatformModel({
    required this.id,
    required this.name,
    required this.slug,
    this.gamesCount,
    this.imageBackground,
    this.releasedAt,
  });
  
  final int id;
  final String name;
  final String slug;
  final int? gamesCount;
  final String? imageBackground;
  final DateTime? releasedAt;

  RawgPlatformModel copyWith({
    int? id,
    String? name,
    String? slug,
    int? gamesCount,
    String? imageBackground,
    DateTime? releasedAt,
  }) =>
      RawgPlatformModel(
        id: id ?? this.id,
        name: name ?? this.name,
        slug: slug ?? this.slug,
        gamesCount: gamesCount ?? this.gamesCount,
        imageBackground: imageBackground ?? this.imageBackground,
        releasedAt: releasedAt ?? this.releasedAt,
      );

  factory RawgPlatformModel.fromJson(String str) =>
      RawgPlatformModel.fromMap(json.decode(str));

  factory RawgPlatformModel.fromMap(Map<String, dynamic> json) =>
      RawgPlatformModel(
        id: json['platform']['id'],
        name: json['platform']['name'],
        slug: json['platform']['slug'],
        gamesCount: json['platform']['games_count'],
        imageBackground: json['platform']['image_background'],
        releasedAt: json["released_at"] != null
            ? DateTime.tryParse(json['released_at'])
            : null,
      );
}
