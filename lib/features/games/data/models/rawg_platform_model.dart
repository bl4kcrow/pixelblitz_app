import 'dart:convert';

class RawgPlatformModel {
  final int id;
  final String name;
  final String slug;
  final String? image;
  final int? yearStart;
  final int gamesCount;
  final String? imageBackground;
  final DateTime? releasedAt;

  RawgPlatformModel({
    required this.id,
    required this.name,
    required this.slug,
    this.image,
    this.yearStart,
    required this.gamesCount,
    this.imageBackground,
    this.releasedAt,
  });

  RawgPlatformModel copyWith({
    int? id,
    String? name,
    String? slug,
    String? image,
    int? yearStart,
    int? gamesCount,
    String? imageBackground,
    DateTime? releasedAt,
  }) =>
      RawgPlatformModel(
        id: id ?? this.id,
        name: name ?? this.name,
        slug: slug ?? this.slug,
        image: image ?? this.image,
        yearStart: yearStart ?? this.yearStart,
        gamesCount: gamesCount ?? this.gamesCount,
        imageBackground: imageBackground ?? this.imageBackground,
        releasedAt: releasedAt ?? this.releasedAt,
      );

  factory RawgPlatformModel.fromJson(String str) =>
      RawgPlatformModel.fromMap(json.decode(str));

  factory RawgPlatformModel.fromMap(Map<String, dynamic> json) =>
      RawgPlatformModel(
        id: json['platform']["id"],
        name: json['platform']["name"],
        slug: json['platform']["slug"],
        image: json['platform']["image"],
        yearStart: json['platform']["year_start"],
        gamesCount: json['platform']["games_count"],
        imageBackground: json['platform']["image_background"],
        releasedAt: json["released_at"] != null
            ? DateTime.tryParse(json["released_at"])
            : null,
      );
}
