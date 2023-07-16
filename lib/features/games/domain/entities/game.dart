import '../domain.dart';

class Game {
  final int id;
  final String name;
  final DateTime? released;
  final String backgroundImage;
  final double rating;
  final int? metacritic;
  final List<Platform> platforms;
  final List<Genre> genres;

  Game({
    required this.id,
    required this.name,
    this.released,
    required this.backgroundImage,
    required this.rating,
    this.metacritic,
    required this.platforms,
    required this.genres,
  });

  Game copyWith({
    int? id,
    String? name,
    DateTime? released,
    String? backgroundImage,
    double? rating,
    int? metacritic,
    List<Platform>? platforms,
    List<Genre>? genres,
  }) =>
      Game(
        id: id ?? this.id,
        name: name ?? this.name,
        released: released ?? this.released,
        backgroundImage: backgroundImage ?? this.backgroundImage,
        rating: rating ?? this.rating,
        metacritic: metacritic ?? this.metacritic,
        platforms: platforms ?? this.platforms,
        genres: genres ?? this.genres,
      );
}
