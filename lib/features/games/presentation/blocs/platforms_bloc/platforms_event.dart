part of 'platforms_bloc.dart';

@immutable
abstract class PlatformsEvent {}

class GetInitialPlatforms extends PlatformsEvent {}

class GetNextPlatforms extends PlatformsEvent {}
