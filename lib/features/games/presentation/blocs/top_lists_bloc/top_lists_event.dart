part of 'top_lists_bloc.dart';

@immutable
abstract class TopListsEvent {}

class GetInitial extends TopListsEvent {
  GetInitial({
    required this.from,
    required this.to,
    this.listType = GameTopLists.recentReleases,
  });

  final DateTime from;
  final DateTime to;
  final GameTopLists listType;
}

class GetNext extends TopListsEvent {}
