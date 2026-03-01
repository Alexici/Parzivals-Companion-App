import 'package:dnd_companion/core/widgets/glass_container.dart';
import 'package:dnd_companion/features/characters/widgets/character_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/theme/app_colors.dart';
import '../providers/character_provider.dart';

class CharactersScreen extends ConsumerWidget {
  const CharactersScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Listen to the character provider
    final characterAsync = ref.watch(userCharactersProvider);

    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // Navigate to character creation screen
          context.push('/create-character');
        },
        backgroundColor: AppColors.royalPurple,
        icon: const Icon(Icons.add, color: Colors.white),
        label: Text(
          'Forge Character',
          style: GoogleFonts.inter(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppColors.deepForest,
              AppColors.abyssalBlack,
              AppColors.charcoal,
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsetsGeometry.symmetric(
              horizontal: 16.0,
              vertical: 24.0,
            ),
            child: characterAsync.when(
              // Loading State
              loading: () => const Center(
                child: CircularProgressIndicator(color: AppColors.royalPurple),
              ),
              // Error State
              error: (err, stack) => Center(
                child: Text(
                  'Failed to load characters. $err',
                  style: GoogleFonts.inter(fontSize: 16, color: Colors.white70),
                ),
              ),
              // Success State
              data: (characters) {
                // Empty State
                if (characters.isEmpty) {
                  return Center(
                    child: GlassContainer(
                      padding: 32,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.auto_awesome,
                            size: 64,
                            color: Colors.white.withValues(alpha: 0.3),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'Your roster is empty!',
                            style: GoogleFonts.medievalSharp(
                              fontSize: 24,
                              color: Colors.white70,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'The realm awaits a new hero.',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.openSans(
                              fontSize: 16,
                              color: Colors.white70,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }
                return ListView.builder(
                  itemCount: characters.length,
                  itemBuilder: (context, index) {
                    final character = characters[index];
                    return CharacterCard(character: character, index: index);
                  },
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
