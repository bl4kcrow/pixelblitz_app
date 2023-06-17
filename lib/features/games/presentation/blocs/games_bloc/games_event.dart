part of 'games_bloc.dart';

@immutable
abstract class GamesEvent {}

class GetNewAndTrending extends GamesEvent {
  GetNewAndTrending({this.page = 1});

  final int page;
}
