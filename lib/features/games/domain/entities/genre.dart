class Genre {
  final int id;
  final String name;
  final String slug;

  Genre({
    required this.id,
    required this.name,
    required this.slug,
  });

  Genre copyWith({
    int? id,
    String? name,
    String? slug,
  }) =>
      Genre(
        id: id ?? this.id,
        name: name ?? this.name,
        slug: slug ?? this.slug,
      );
  
  @override
  String toString() {
    return name;
  }
}
