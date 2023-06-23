import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../presentation.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);

    return Scaffold(
      body: BlocBuilder<GamesBloc, GamesState>(
        builder: (context, state) {
          if (state.requestStatus == GamesRequestStatus.success) {
            return Column(
              children: [
                SizedBox(
                  height: screenSize.height * 0.4,
                  width: double.maxFinite,
                  child: CardSwiper(
                    games: state.games,
                  ),
                ),
              ],
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
