part of 'games_by_platform_bloc.dart';

@immutable
abstract class GamesByPlatformEvent {}

class GetInitialGamesByPlatform extends GamesByPlatformEvent {
  GetInitialGamesByPlatform({
    required this.platformIds,
  });

  final List<int> platformIds;
}

class GetNextGamesByPlatform extends GamesByPlatformEvent {}
