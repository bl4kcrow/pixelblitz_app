part of 'platforms_bloc.dart';

class PlatformsState extends Equatable {
  const PlatformsState({
    this.platforms = const [],
    this.requestStatus = GamesRequestStatus.initial,
  });

  final List<Platform> platforms;
  final GamesRequestStatus requestStatus;

  PlatformsState copyWith({
    List<Platform>? platforms,
    GamesRequestStatus? requestStatus,
  }) =>
      PlatformsState(
        platforms: platforms ?? this.platforms,
        requestStatus: requestStatus ?? this.requestStatus,
      );

  @override
  List<Object?> get props => [
        platforms,
        requestStatus,
      ];
}
