import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../features/games/presentation/presentation.dart';
import 'utils.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
    required this.title,
  }) : preferredSize = const Size.fromHeight(60.0);

  @override
  final Size preferredSize;

  final String title;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      centerTitle: true,
      actions: [
        IconButton(
          onPressed: () {
            showSearch(
              query: context.read<SearchGamesBloc>().currentSearchQuery,
              context: context,
              delegate: GamesSearchDelegate(),
            );
          },
          icon: const FaIcon(
            FontAwesomeIcons.magnifyingGlass,
          ),
        ),
        IconButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (_) => const InfoALertDialog(),
            );
          },
          icon: const FaIcon(
            FontAwesomeIcons.circleInfo,
          ),
        ),
      ],
    );
  }
}
