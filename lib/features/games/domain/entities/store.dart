class Store {
  final int id;
  final String name;
  final String slug;
  final String? domain;

  Store({
    required this.id,
    required this.name,
    required this.slug,
    this.domain,
  });

  Store copyWith({
    int? id,
    String? name,
    String? slug,
    String? domain,
  }) =>
      Store(
        id: id ?? this.id,
        name: name ?? this.name,
        slug: slug ?? this.slug,
        domain: domain ?? this.domain,
      );
  
  @override
  String toString() {
    return name;
  }
}
