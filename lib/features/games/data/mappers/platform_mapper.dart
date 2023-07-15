import '../data.dart';
import '../../domain/domain.dart';

class PlatformMapper {
  static rawgPlatformToEntity(RawgPlatformModel rawgPlatformModel) {
    return Platform(
      id: rawgPlatformModel.id,
      name: rawgPlatformModel.name,
      slug: rawgPlatformModel.slug,
    );
  }
}
