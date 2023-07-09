class GameScreenshot {
  GameScreenshot({
    required this.id,
    required this.image,
    required this.isDeleted,
  });

  final int id;
  final String image;
  final bool isDeleted;

  GameScreenshot copyWith({
    int? id,
    String? image,
    bool? isDeleted,
  }) =>
      GameScreenshot(
        id: id ?? this.id,
        image: image ?? this.image,
        isDeleted: isDeleted ?? this.isDeleted,
      );
}
