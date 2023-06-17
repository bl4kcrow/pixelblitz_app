import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'core/routes/routes.dart';
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
    return RepositoryProvider(
      create: (context) => GamesRepositoryImpl(RawgGamesDatasource()),
      child: BlocProvider(
        create: (context) => GamesBloc(context.read<GamesRepositoryImpl>())
          ..add(
            GetNewAndTrending(),
          ),
        child: MaterialApp.router(
          debugShowCheckedModeBanner: false,
          routerConfig: appRouter,
        ),
      ),
    );
  }
}
