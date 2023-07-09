import 'dart:convert';

class RawgGameScreenshotModel {
  RawgGameScreenshotModel({
    required this.id,
    required this.image,
    required this.isDeleted,
  });

  final int id;
  final String image;
  final bool isDeleted;

  RawgGameScreenshotModel copyWith({
    int? id,
    String? image,
    bool? isDeleted,
  }) =>
      RawgGameScreenshotModel(
        id: id ?? this.id,
        image: image ?? this.image,
        isDeleted: isDeleted ?? this.isDeleted,
      );

  factory RawgGameScreenshotModel.fromJson(String str) =>
      RawgGameScreenshotModel.fromMap(json.decode(str));

  factory RawgGameScreenshotModel.fromMap(Map<String, dynamic> json) =>
      RawgGameScreenshotModel(
        id: json['id'],
        image: json['image'],
        isDeleted: json['is_deleted'],
      );
}
