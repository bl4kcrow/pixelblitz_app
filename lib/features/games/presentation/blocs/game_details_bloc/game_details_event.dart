part of 'game_details_bloc.dart';

@immutable
abstract class GameDetailsEvent {}

class GetDetails extends GameDetailsEvent {
  GetDetails({
    required this.id,
  });

  final int id;
}
