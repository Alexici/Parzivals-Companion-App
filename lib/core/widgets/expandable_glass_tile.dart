// lib/core/widgets/expandable_glass_tile.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../theme/app_colors.dart';
import 'glass_container.dart';

class ExpandableGlassTile extends StatelessWidget {
  final String title;
  final String description;
  final bool isHighlighted;

  const ExpandableGlassTile({
    super.key,
    required this.title,
    required this.description,
    this.isHighlighted = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: GlassContainer(
        padding: 0,
        child: Theme(
          data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
          child: ExpansionTile(
            title: Text(
              title,
              style: GoogleFonts.inter(
                color: isHighlighted ? AppColors.legendaryGold : Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            iconColor: Colors.white,
            collapsedIconColor: Colors.white54,
            childrenPadding: const EdgeInsets.only(
              left: 16,
              right: 16,
              bottom: 16,
            ),
            children: [
              Text(
                description,
                style: GoogleFonts.inter(color: Colors.white70, height: 1.5),
                textAlign: TextAlign.left,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
