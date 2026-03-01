import 'package:dnd_companion/core/widgets/glass_container.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../models/character.dart';

class CharacterCard extends StatelessWidget {
  final Character character;
  final int index;

  const CharacterCard({
    super.key,
    required this.character,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeOutCubic,
      builder: (context, value, child) {
        return Transform.translate(
          offset: Offset(0, 50 * (1 - value)),
          child: Opacity(opacity: value, child: child),
        );
      },
      child: Padding(
        padding: const EdgeInsets.only(bottom: 16.0),
        child: GlassContainer(
          child: Row(
            children: [
              // Placeholder for character image
              CircleAvatar(
                backgroundColor: Colors.white.withValues(alpha: 0.2),
                radius: 24,
                child: const Icon(Icons.shield, color: Colors.white70),
              ),
              const SizedBox(width: 16),
              // Character name and details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      character.name,
                      style: GoogleFonts.medievalSharp(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Level ${character.level} • ${character.race} ${character.characterClass}',
                      style: GoogleFonts.openSans(
                        fontSize: 14,
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
              ),
              // Arrow to indicate navigation
              const Icon(Icons.chevron_right, color: Colors.white54),
            ],
          ),
        ),
      ),
    );
  }
}
