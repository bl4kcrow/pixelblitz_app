import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/theme/theme.dart';
import '../../../../core/utils/utils.dart';
import '../presentation.dart';

class HorizontalGenresGridList extends StatefulWidget {
  const HorizontalGenresGridList({super.key});

  @override
  State<HorizontalGenresGridList> createState() =>
      _HorizontalGenresGridListState();
}

class _HorizontalGenresGridListState extends State<HorizontalGenresGridList> {
  final List<int> genresSelected = [];
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    if (scrollController.offset >= scrollController.position.maxScrollExtent &&
        !scrollController.position.outOfRange) {
      if (context.read<GenresBloc>().haveNext) {
        context.read<GenresBloc>().add(GetNextGenres());
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
    final TextTheme textTheme = Theme.of(context).textTheme;

    return BlocBuilder<GenresBloc, GenresState>(
      builder: (context, state) {
        if (state.requestStatus == GamesRequestStatus.success) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: GridView.builder(
                  controller: scrollController,
                  scrollDirection: Axis.horizontal,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: Insets.small,
                    crossAxisSpacing: Insets.small,
                    childAspectRatio: 2 / 6,
                  ),
                  itemCount: state.genres.length,
                  itemBuilder: (context, index) {
                    final genre = state.genres[index];
                    final bool isSelected = genresSelected.contains(genre.id);

                    return SelectableButton(
                      label: genre.name,
                      isSelected: isSelected,
                      onPressed: () {
                        if (genresSelected.contains(genre.id)) {
                          genresSelected.remove(genre.id);
                        } else {
                          genresSelected.add(genre.id);
                        }
                        setState(() {});

                        context
                            .read<GamesByGenreBloc>()
                            .add(GetInitialGamesByGenre(
                              genresIds: genresSelected,
                            ));
                      },
                    );
                  },
                ),
              ),
              GestureDetector(
                onTap: () {
                  genresSelected.clear();
                  context.read<GamesByGenreBloc>().add(
                        GetInitialGamesByGenre(
                          genresIds: genresSelected,
                        ),
                      );

                  setState(() {});
                },
                child: Padding(
                  padding: const EdgeInsets.all(Insets.small),
                  child: Text(
                    Labels.clearAll,
                    style: textTheme.labelMedium?.copyWith(
                      color: AppColors.melon,
                    ),
                  ),
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
    );
  }
}
