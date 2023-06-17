import 'dart:convert';

class RawgGenreModel {
  final int id;
  final String name;
  final String slug;

  RawgGenreModel({
    required this.id,
    required this.name,
    required this.slug,
  });

  RawgGenreModel copyWith({
    int? id,
    String? name,
    String? slug,
  }) =>
      RawgGenreModel(
        id: id ?? this.id,
        name: name ?? this.name,
        slug: slug ?? this.slug,
      );

  factory RawgGenreModel.fromJson(String str) =>
      RawgGenreModel.fromMap(json.decode(str));

  factory RawgGenreModel.fromMap(Map<String, dynamic> json) => RawgGenreModel(
        id: json['id'],
        name: json['name'],
        slug: json['slug'],
      );
}
