import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../core/theme/theme.dart';
import '../../domain/domain.dart';

class GridCards extends StatelessWidget {
  const GridCards({
    super.key,
    required this.games,
    required this.scrollController,
  });

  final List<Game> games;
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      controller: scrollController,
      itemCount: games.length,
      padding: const EdgeInsets.all(Insets.xsmall),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        childAspectRatio: 16 / 9,
        crossAxisCount: 2,
        mainAxisSpacing: Insets.medium,
        crossAxisSpacing: Insets.small,
      ),
      itemBuilder: (context, index) {
        final game = games[index];

        return Stack(
          alignment: Alignment.bottomLeft,
          children: [
            SizedBox.expand(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  boxShadow: const [
                    BoxShadow(
                      color: AppColors.black,
                      spreadRadius: 1.0,
                      blurRadius: 3.0,
                      offset: Offset(0.0, 0.0),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: CachedNetworkImage(
                    imageUrl: game.backgroundImage,
                    fit: BoxFit.cover,
                    memCacheHeight: 2160,
                    memCacheWidth: 3840,
                  ),
                ),
              ),
            ),
            SizedBox.expand(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  gradient: const LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      AppColors.black,
                    ],
                    stops: [
                      0.5,
                      1.0,
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(Insets.small),
              child: Text(
                game.name,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        );
      },
    );
  }
}
