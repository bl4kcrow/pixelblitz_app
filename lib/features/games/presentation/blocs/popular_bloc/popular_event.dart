part of 'popular_bloc.dart';

@immutable
abstract class PopularEvent {}

class GetInitialPopular extends PopularEvent {
  GetInitialPopular({
    required this.from,
    required this.to,
  });

  final DateTime from;
  final DateTime to;
}

class GetNextPopular extends PopularEvent {
  GetNextPopular({
    required this.from,
    required this.to,
    required this.page,
  });

  final DateTime from;
  final DateTime to;
  final int page;
}
