import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

import '../constants/constants.dart';
import '../theme/theme.dart';

class NestedBottomNavigationBar extends StatelessWidget {
  const NestedBottomNavigationBar({
    Key? key,
    required this.navigationShell,
  }) : super(
          key: key ?? const ValueKey('NestedBottomNavigationBar'),
        );

  final StatefulNavigationShell navigationShell;

  void _goBranch(int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light.copyWith(
        systemNavigationBarColor: AppColors.eerieBlack,
        systemNavigationBarIconBrightness: Brightness.light,
      ),
      child: Scaffold(
        body: navigationShell,
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: navigationShell.currentIndex,
          selectedItemColor: AppColors.congoPink,
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(
              label: Labels.home,
              icon: FaIcon(FontAwesomeIcons.houseFire),
            ),
            BottomNavigationBarItem(
              label: Labels.platforms,
              icon: FaIcon(FontAwesomeIcons.computer),
            ),
            BottomNavigationBarItem(
              label: Labels.genres,
              icon: FaIcon(FontAwesomeIcons.shieldHalved),
            ),
          ],
          onTap: (value) => _goBranch(value),
        ),
      ),
    );
  }
}
