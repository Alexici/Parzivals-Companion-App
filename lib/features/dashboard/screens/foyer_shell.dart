import 'package:dnd_companion/features/dashboard/widgets/foyer_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../widgets/foyer_nav_rail.dart';

class FoyerShell extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const FoyerShell({super.key, required this.navigationShell});

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width >= 800;

    return Scaffold(
      body: Row(
        children: [
          if (isDesktop)
            FoyerNavRail(
              currentIndex: navigationShell.currentIndex,
              onTap: (index) => _goBranch(index),
            ),
          Expanded(child: navigationShell),
        ],
      ),
      bottomNavigationBar: isDesktop
          ? null
          : FoyerBottomBar(
              currentIndex: navigationShell.currentIndex,
              onTap: (index) => _goBranch(index),
            ),
    );
  }

  void _goBranch(int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }
}
