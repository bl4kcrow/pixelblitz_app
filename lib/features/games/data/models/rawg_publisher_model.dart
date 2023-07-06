import 'dart:convert';

class RawgPublisherModel {
  RawgPublisherModel({
    required this.id,
    required this.name,
    required this.slug,
    this.gamesCount,
  });

  final int id;
  final String name;
  final String slug;
  final int? gamesCount;

  RawgPublisherModel copyWith({
    int? id,
    String? name,
    String? slug,
    int? gamesCount,
  }) =>
      RawgPublisherModel(
        id: id ?? this.id,
        name: name ?? this.name,
        slug: slug ?? this.slug,
        gamesCount: gamesCount ?? this.gamesCount,
      );

  factory RawgPublisherModel.fromJson(String str) =>
      RawgPublisherModel.fromMap(json.decode(str));

  factory RawgPublisherModel.fromMap(Map<String, dynamic> json) =>
      RawgPublisherModel(
        id: json['id'],
        name: json['name'],
        slug: json['slug'],
        gamesCount: json['games_count'],
      );
}
