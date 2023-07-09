part of 'game_screenshots_bloc.dart';

class GameScreenshotsState extends Equatable {
  const GameScreenshotsState({
    this.gameScreenshots = const [],
    this.requestStatus = GamesRequestStatus.initial,
  });

  final List<GameScreenshot> gameScreenshots;
  final GamesRequestStatus requestStatus;

  GameScreenshotsState copyWith({
    List<GameScreenshot>? gameScreenshots,
    GamesRequestStatus? requestStatus,
  }) =>
      GameScreenshotsState(
        gameScreenshots: gameScreenshots ?? this.gameScreenshots,
        requestStatus: requestStatus ?? this.requestStatus,
      );

  @override
  List<Object?> get props => [
        gameScreenshots,
        requestStatus,
      ];
}
