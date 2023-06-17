import 'dart:convert';

class RawgTagModel {
  final int id;
  final String name;
  final String slug;

  RawgTagModel({
    required this.id,
    required this.name,
    required this.slug,
  });

  RawgTagModel copyWith({
    int? id,
    String? name,
    String? slug,
  }) =>
      RawgTagModel(
        id: id ?? this.id,
        name: name ?? this.name,
        slug: slug ?? this.slug,
      );

  factory RawgTagModel.fromJson(String str) =>
      RawgTagModel.fromMap(json.decode(str));

  factory RawgTagModel.fromMap(Map<String, dynamic> json) => RawgTagModel(
        id: json["id"],
        name: json["name"],
        slug: json["slug"],
      );
}
