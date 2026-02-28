import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';

class FoyerBottomBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const FoyerBottomBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      backgroundColor: AppColors.midnightBlue,
      indicatorColor: AppColors.royalPurple.withValues(alpha: 0.5),
      selectedIndex: currentIndex,
      onDestinationSelected: onTap,
      labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
      destinations: [
        NavigationDestination(
          icon: Icon(Icons.group_outlined, color: Colors.white70),
          selectedIcon: Icon(Icons.group, color: Colors.white),
          label: 'Characters',
        ),
        NavigationDestination(
          icon: Icon(Icons.map_outlined, color: Colors.white70),
          selectedIcon: Icon(Icons.map, color: Colors.white),
          label: 'Campaigns',
        ),
        NavigationDestination(
          icon: Icon(Icons.person_outlined, color: Colors.white70),
          selectedIcon: Icon(Icons.person, color: Colors.white),
          label: 'Settings',
        ),
      ],
    );
  }
}
