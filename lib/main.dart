import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'core/routes/routes.dart';
import 'core/theme/theme.dart';
import 'features/games/data/data.dart';
import 'features/games/presentation/presentation.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: '.env');

  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => GamesRepositoryImpl(
            RawgGamesDatasource(),
          ),
        ),
        RepositoryProvider(
          create: (context) => PlatformsRepositoryImpl(
            RawgPlatformsDatasource(),
          ),
        ),
        RepositoryProvider(
          create: (context) => GenresRepositoryImpl(
            RawgGenresDatasource(),
          ),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) =>
                NewAndTrendingBloc(context.read<GamesRepositoryImpl>())
                  ..add(GetNewAndTrending()),
          ),
          BlocProvider(create: (context) {
            final DateTime dateTimeNow = DateTime.now();
            return TopListsBloc(context.read<GamesRepositoryImpl>())
              ..add(
                GetInitial(
                  from: DateTime(
                    dateTimeNow.year,
                    dateTimeNow.month - 1,
                  ),
                  to: dateTimeNow,
                ),
              );
          }),
          BlocProvider(
            create: (context) =>
                GameDetailsBloc(context.read<GamesRepositoryImpl>()),
          ),
          BlocProvider(
            create: (context) =>
                GameScreenshotsBloc(context.read<GamesRepositoryImpl>()),
          ),
          BlocProvider(
            create: (context) =>
                GameSeriesBloc(context.read<GamesRepositoryImpl>()),
          ),
          BlocProvider(
            create: (context) =>
                PlatformsBloc(context.read<PlatformsRepositoryImpl>()),
          ),
          BlocProvider(
            create: (context) =>
                GamesByPlatformBloc(context.read<GamesRepositoryImpl>()),
          ),
          BlocProvider(
            create: (context) =>
                GenresBloc(context.read<GenresRepositoryImpl>()),
          ),
          BlocProvider(
            create: (context) =>
                GamesByGenreBloc(context.read<GamesRepositoryImpl>()),
          ),
          BlocProvider(
            create: (context) =>
                SearchGamesBloc(context.read<GamesRepositoryImpl>()),
          ),
        ],
        child: MaterialApp.router(
          debugShowCheckedModeBanner: false,
          routerConfig: appRouter,
          theme: appTheme,
        ),
      ),
    );
  }
}
