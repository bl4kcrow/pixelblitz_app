class Platform {
  final int id;
  final String name;
  final String slug;
  final int gamesCount;
  final String? imageBackground;
  final DateTime? releasedAt;

  Platform({
    required this.id,
    required this.name,
    required this.slug,
    required this.gamesCount,
    this.imageBackground,
    this.releasedAt,
  });

  Platform copyWith({
    int? id,
    String? name,
    String? slug,
    int? gamesCount,
    String? imageBackground,
    DateTime? releasedAt,
  }) =>
      Platform(
        id: id ?? this.id,
        name: name ?? this.name,
        slug: slug ?? this.slug,
        gamesCount: gamesCount ?? this.gamesCount,
        imageBackground: imageBackground ?? this.imageBackground,
        releasedAt: releasedAt ?? this.releasedAt,
      );
}
