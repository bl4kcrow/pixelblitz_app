import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/routes/routes.dart';
import '../../../../core/theme/theme.dart';
import '../../../../core/utils/utils.dart';
import '../../domain/domain.dart';
import '../presentation.dart';

class GamesSearchResultList extends StatefulWidget {
  const GamesSearchResultList({
    super.key,
    this.voidCallback,
  });

  final VoidCallback? voidCallback;

  @override
  State<GamesSearchResultList> createState() => _GameSearchResultListState();
}

class _GameSearchResultListState extends State<GamesSearchResultList> {
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    if (scrollController.offset >= scrollController.position.maxScrollExtent &&
        !scrollController.position.outOfRange) {
      if (context.read<SearchGamesBloc>().haveNext) {
        context.read<SearchGamesBloc>().add(GetNextSearchGames());
      }
    }
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchGamesBloc, SearchGamesState>(
      builder: (context, state) {
        if (state.requestStatus == GamesRequestStatus.initial ||
            state.requestStatus == GamesRequestStatus.success) {
          if (state.games.isEmpty) {
            return const Center(
              child: NoDataAnimation(label: Labels.searchAGameMyFriend),
            );
          } else {
            return ListView.separated(
              controller: scrollController,
              itemCount: state.games.length,
              itemBuilder: (
                BuildContext context,
                int index,
              ) {
                final Game game = state.games[index];
                final String heroId = 'searchList-${game.id}';

                return ListTile(
                  leading: AspectRatio(
                    aspectRatio: 16 / 9,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(AppRadius.xsmall),
                      child: CachedNetworkImage(
                        imageUrl: game.backgroundImage,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  title: Text(
                    game.name,
                    overflow: TextOverflow.ellipsis,
                  ),
                  subtitle: Text(
                    game.released != null
                        ? DateFormat.yMMMd().format(game.released!)
                        : Labels.notApplicable,
                  ),
                  visualDensity: const VisualDensity(vertical: 4),
                  onTap: () {
                    context.read<GameDetailsBloc>().add(
                          GetDetails(id: game.id),
                        );
                    context
                        .read<GameScreenshotsBloc>()
                        .add(GetInitialScreenshots(id: game.id));
                    context
                        .read<GameSeriesBloc>()
                        .add(GetInitialGameSeries(id: game.id));
                    context.pushNamed(
                      RoutesName.gameDetailsScreen,
                      extra: heroId,
                    );
                  },
                );
              },
              separatorBuilder: (_, __) {
                return const SizedBox(
                  height: Insets.xsmall / 2,
                );
              },
            );
          }
        } else {
          return const Center(
            child: SpinnerIndicator(),
          );
        }
      },
    );
  }
}
