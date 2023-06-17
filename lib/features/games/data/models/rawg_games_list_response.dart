import 'package:flutter/material.dart';
import 'package:pixelblitz_app/features/games/data/models/rawg_game_model.dart';

class RawgGamesListResponse {
  RawgGamesListResponse({
    required this.count,
    required this.next,
    required this.previous,
    required this.results,
  });

  final int count;
  final String next;
  final String? previous;
  final List<RawgGameModel> results;

  factory RawgGamesListResponse.fromJson(Map<String, dynamic> json) =>
      RawgGamesListResponse(
        count: json['count'],
        next: json['next'],
        previous: json['previous'],
        results: List<RawgGameModel>.from(
          json['results'].map((rawgGame) {
            debugPrint('results');
            return RawgGameModel.fromMap(rawgGame);
          }),
        ),
      );
}
