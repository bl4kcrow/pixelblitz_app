import '../../domain/domain.dart';
import '../data.dart';

class GameScreenshotMapper {
  static GameScreenshot rawgGameScreenshotToEntity(
          RawgGameScreenshotModel rawgScreenshot) =>
      GameScreenshot(
        id: rawgScreenshot.id,
        image: rawgScreenshot.image,
        isDeleted: rawgScreenshot.isDeleted,
      );
}
