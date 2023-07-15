import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/utils.dart';
import '../../../../core/theme/theme.dart';
import '../presentation.dart';

class PlatformsScreen extends StatefulWidget {
  const PlatformsScreen({super.key});

  @override
  State<PlatformsScreen> createState() => _PlatformsScreenState();
}

class _PlatformsScreenState extends State<PlatformsScreen> {
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    context.read<PlatformsBloc>().add(GetInitialPlatforms());
    context
        .read<GamesByPlatformBloc>()
        .add(GetInitialGamesByPlatform(platformIds: const []));
    scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    if (scrollController.offset >= scrollController.position.maxScrollExtent &&
        !scrollController.position.outOfRange) {
      if (context.read<GamesByPlatformBloc>().haveNext) {
        context.read<GamesByPlatformBloc>().add(GetNextGamesByPlatform());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Platforms'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: Insets.medium),
        child: Column(
          children: [
            const HorizontalPlatformsList(),
            Expanded(
              child: BlocBuilder<GamesByPlatformBloc, GamesByPlatformState>(
                builder: (context, state) {
                  if (state.requestStatus == GamesRequestStatus.success) {
                    return GamesList(
                      games: state.games,
                      listController: scrollController,
                    );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator.adaptive(),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
