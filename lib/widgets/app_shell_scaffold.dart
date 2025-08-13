import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'bottom_menu.dart';

class AppShellScaffold extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const AppShellScaffold({super.key, required this.navigationShell});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // текущая ветка
        Positioned.fill(child: navigationShell),
        // плавающее нижнее меню поверх
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          child: BottomMenu(
            selected:
                navigationShell.currentIndex == 0
                    ? BottomTab.home
                    : BottomTab.favorites,
            onHomeTap:
                () => navigationShell.goBranch(0, initialLocation: false),
            onFavoritesTap:
                () => navigationShell.goBranch(1, initialLocation: false),
          ),
        ),
      ],
    );
  }
}
