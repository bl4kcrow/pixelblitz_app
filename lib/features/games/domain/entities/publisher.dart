class Publisher {
  Publisher({
    required this.id,
    required this.name,
    required this.slug,
    this.gamesCount,
  });

  final int id;
  final String name;
  final String slug;
  final int? gamesCount;

  Publisher copyWith({
    int? id,
    String? name,
    String? slug,
    int? gamesCount,
  }) =>
      Publisher(
        id: id ?? this.id,
        name: name ?? this.name,
        slug: slug ?? this.slug,
        gamesCount: gamesCount ?? this.gamesCount,
      );
  
  @override
  String toString() {
    return name;
  }
}
