import '../data.dart';
import '../../domain/domain.dart';

class GenreMapper {
  static rawgGenreToEntity(RawgGenreModel rawgGenreModel) {
    return Genre(
      id: rawgGenreModel.id,
      name: rawgGenreModel.name,
      slug: rawgGenreModel.slug,
    );
  }
}
