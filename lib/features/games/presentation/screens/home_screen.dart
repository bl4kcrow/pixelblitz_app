import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../presentation.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    if (scrollController.offset >= scrollController.position.maxScrollExtent &&
        !scrollController.position.outOfRange) {
      context.read<GamesBloc>().add(GetNewAndTrending());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<GamesBloc, GamesState>(
        builder: (context, state) {
          if (state.requestStatus == GamesRequestStatus.success) {
            return ListView.builder(
              controller: scrollController,
              itemCount: state.games.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(state.games[index].name),
                  subtitle: Text(state.games[index].id.toString()),
                );
              },
            );
          } else {
            return const Center(child: CircularProgressIndicator.adaptive());
          }
        },
      ),
    );
  }
}
