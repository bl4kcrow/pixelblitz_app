class Platform {
  final int id;
  final String name;
  final String slug;
  final dynamic image;
  final dynamic yearEnd;
  final int? yearStart;
  final int gamesCount;
  final String? imageBackground;
  final DateTime? releasedAt;

  Platform({
    required this.id,
    required this.name,
    required this.slug,
    this.image,
    this.yearEnd,
    this.yearStart,
    required this.gamesCount,
    this.imageBackground,
    this.releasedAt,
  });

  Platform copyWith({
    int? id,
    String? name,
    String? slug,
    dynamic image,
    dynamic yearEnd,
    int? yearStart,
    int? gamesCount,
    String? imageBackground,
    DateTime? releasedAt,
  }) =>
      Platform(
        id: id ?? this.id,
        name: name ?? this.name,
        slug: slug ?? this.slug,
        image: image ?? this.image,
        yearEnd: yearEnd ?? this.yearEnd,
        yearStart: yearStart ?? this.yearStart,
        gamesCount: gamesCount ?? this.gamesCount,
        imageBackground: imageBackground ?? this.imageBackground,
        releasedAt: releasedAt ?? this.releasedAt,
      );
}
