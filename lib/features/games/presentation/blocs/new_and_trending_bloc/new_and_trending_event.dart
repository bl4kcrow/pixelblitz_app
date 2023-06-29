part of 'new_and_trending_bloc.dart';

@immutable
abstract class NewAndTrendingEvent {}

class GetNewAndTrending extends NewAndTrendingEvent {
  GetNewAndTrending({this.page = 1});

  final int page;
}
