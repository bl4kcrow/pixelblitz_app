part of 'game_details_bloc.dart';

class GameDetailsState extends Equatable {
  const GameDetailsState({
    required this.gameDetails,
    this.requestStatus = GamesRequestStatus.initial,
  });

  final GameDetails gameDetails;
  final GamesRequestStatus requestStatus;

  GameDetailsState copyWith({
    GameDetails? gameDetails,
    GamesRequestStatus? requestStatus,
  }) =>
      GameDetailsState(
        gameDetails: gameDetails ?? this.gameDetails,
        requestStatus: requestStatus ?? this.requestStatus,
      );

  @override
  List<Object?> get props => [
        gameDetails,
        requestStatus,
      ];
}
