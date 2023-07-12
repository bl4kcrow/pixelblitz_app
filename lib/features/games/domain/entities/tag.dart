class Tag {
  final int id;
  final String name;
  final String slug;

  Tag({
    required this.id,
    required this.name,
    required this.slug,
  });

  Tag copyWith({
    int? id,
    String? name,
    String? slug,
  }) =>
      Tag(
        id: id ?? this.id,
        name: name ?? this.name,
        slug: slug ?? this.slug,
      );
  
  @override
  String toString() {
    return name;
  }
}
