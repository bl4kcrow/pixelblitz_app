import 'package:go_router/go_router.dart';

import '../../features/games/presentation/presentation.dart';
import 'routes.dart';

final appRouter = GoRouter(
  routes: [
    GoRoute(
      path: RoutesName.homeScreen,
      builder: (context, state) => const HomeScreen(),
    ),
  ],
);
