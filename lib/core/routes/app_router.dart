import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../features/games/presentation/presentation.dart';
import '../utils/utils.dart';
import 'routes.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorAKey = GlobalKey<NavigatorState>(debugLabel: 'shellA');
final _shellNavigatorBKey = GlobalKey<NavigatorState>(debugLabel: 'shellB');
final _shellNavigatorCKey = GlobalKey<NavigatorState>(debugLabel: 'shellC');

final appRouter = GoRouter(
  initialLocation: RoutesName.homeScreen,
  navigatorKey: _rootNavigatorKey,
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return NestedBottomNavigationBar(
          navigationShell: navigationShell,
        );
      },
      branches: [
        StatefulShellBranch(
          navigatorKey: _shellNavigatorAKey,
          routes: [
            GoRoute(
              path: RoutesName.homeScreen,
              builder: (context, state) => const HomeScreen(),
              routes: [
                GoRoute(
                  parentNavigatorKey: _rootNavigatorKey,
                  name: RoutesName.gameDetailsScreen,
                  path: RoutesName.gameDetailsScreen,
                  builder: (context, state) => GameDetailsScreen(
                    heroId: state.extra as String,
                  ),
                ),
              ],
            ),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: _shellNavigatorBKey,
          routes: [
            GoRoute(
              path: RoutesName.platformsScreen,
              builder: (context, state) => const PlatformsScreen(),
              routes: [
                GoRoute(
                  parentNavigatorKey: _rootNavigatorKey,
                  path: RoutesName.gameDetailsScreen,
                  builder: (context, state) => GameDetailsScreen(
                    heroId: state.extra as String,
                  ),
                ),
              ],
            ),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: _shellNavigatorCKey,
          routes: [
            GoRoute(
              path: RoutesName.genresScreen,
              builder: (context, state) => const GenresScreen(),
              routes: [
                GoRoute(
                  parentNavigatorKey: _rootNavigatorKey,
                  path: RoutesName.gameDetailsScreen,
                  builder: (context, state) => GameDetailsScreen(
                    heroId: state.extra as String,
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  ],
);
