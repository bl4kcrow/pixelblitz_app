class Platform {
  Platform({
    required this.id,
    required this.name,
    required this.slug,
    this.gamesCount,
    this.releasedAt,
  });
  
  final int id;
  final String name;
  final String slug;
  final int? gamesCount;
  final DateTime? releasedAt;

  Platform copyWith({
    int? id,
    String? name,
    String? slug,
    int? gamesCount,
    DateTime? releasedAt,
  }) =>
      Platform(
        id: id ?? this.id,
        name: name ?? this.name,
        slug: slug ?? this.slug,
        gamesCount: gamesCount ?? this.gamesCount,
        releasedAt: releasedAt ?? this.releasedAt,
      );
}
