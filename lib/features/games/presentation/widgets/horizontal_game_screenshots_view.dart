import 'package:cached_network_image/cached_network_image.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theme/theme.dart';
import '../../../../core/utils/utils.dart';
import '../presentation.dart';

class HorizontalGameScreenshotsView extends StatelessWidget {
  const HorizontalGameScreenshotsView({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);

    return SizedBox(
      height: screenSize.width * 0.5,
      width: double.maxFinite,
      child: BlocBuilder<GameScreenshotsBloc, GameScreenshotsState>(
        builder: (context, state) {
          if (state.requestStatus == GamesRequestStatus.success) {
            return Swiper(
              itemCount: state.gameScreenshots.length,
              scale: 0.9,
              viewportFraction: 0.8,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    boxShadow: const [
                      BoxShadow(
                        color: AppColors.congoPink,
                        spreadRadius: 1.0,
                        blurRadius: 2.0,
                      ),
                    ],
                  ),
                  margin: const EdgeInsets.symmetric(vertical: Insets.small),
                  child: AspectRatio(
                    aspectRatio: 16 / 9,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: CachedNetworkImage(
                        imageUrl: state.gameScreenshots[index].image,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                );
              },
            );
          } else {
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          }
        },
      ),
    );
  }
}
