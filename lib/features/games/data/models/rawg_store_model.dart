import 'dart:convert';

class RawgStoreModel {
  final int id;
  final String name;
  final String slug;
  final String? domain;

  RawgStoreModel({
    required this.id,
    required this.name,
    required this.slug,
    this.domain,
  });

  RawgStoreModel copyWith({
    int? id,
    String? name,
    String? slug,
    String? domain,
  }) =>
      RawgStoreModel(
        id: id ?? this.id,
        name: name ?? this.name,
        slug: slug ?? this.slug,
        domain: domain ?? this.domain,
      );

  factory RawgStoreModel.fromJson(String str) =>
      RawgStoreModel.fromMap(json.decode(str));

  factory RawgStoreModel.fromMap(Map<String, dynamic> json) => RawgStoreModel(
        id: json['store']["id"],
        name: json['store']["name"],
        slug: json['store']["slug"],
        domain: json['store']["domain"],
      );
}
