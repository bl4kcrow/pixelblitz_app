part of 'game_screenshots_bloc.dart';

@immutable
abstract class GameScreenshotsEvent {}

class GetInitialScreenshots extends GameScreenshotsEvent {
  GetInitialScreenshots({
    required this.id,
  });

  final int id;
}

class GetNextScreenshots extends GameScreenshotsEvent {}
