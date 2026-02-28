import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';

class FoyerNavRail extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const FoyerNavRail({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return NavigationRail(
      backgroundColor: AppColors.midnightBlue,
      indicatorColor: AppColors.royalPurple.withValues(alpha: 0.5),
      selectedIconTheme: const IconThemeData(color: Colors.white),
      unselectedIconTheme: const IconThemeData(color: Colors.white70),
      selectedLabelTextStyle: const TextStyle(color: Colors.white),
      selectedIndex: currentIndex,
      onDestinationSelected: onTap,
      destinations: [
        NavigationRailDestination(
          icon: Icon(Icons.group_outlined, color: Colors.white70),
          selectedIcon: Icon(Icons.group, color: Colors.white),
          label: Text('Characters'),
        ),
        NavigationRailDestination(
          icon: Icon(Icons.map_outlined, color: Colors.white70),
          selectedIcon: Icon(Icons.map, color: Colors.white),
          label: Text('Campaigns'),
        ),
        NavigationRailDestination(
          icon: Icon(Icons.person_outlined, color: Colors.white70),
          selectedIcon: Icon(Icons.person, color: Colors.white),
          label: Text('Profile'),
        ),
      ],
    );
  }
}
