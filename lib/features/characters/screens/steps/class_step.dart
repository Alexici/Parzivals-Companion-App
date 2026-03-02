import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/expandable_glass_tile.dart';
import '../../../../core/widgets/glass_container.dart';
import '../../data/mock_class_data.dart';
import '../../models/character_class.dart';
import '../../providers/character_draft_provider.dart';

class ClassStep extends ConsumerWidget {
  const ClassStep({super.key});

  void _openClassModal(
    BuildContext context,
    CharacterClass classData,
    WidgetRef ref,
  ) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: 'Dismiss',
      barrierColor: Colors.black.withValues(alpha: 0.6),
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (context, animation, secondaryAnimation) {
        return ClassDetailsModal(classData: classData, ref: ref);
      },
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        return SlideTransition(
          position: Tween<Offset>(begin: const Offset(0, 1), end: Offset.zero)
              .animate(
                CurvedAnimation(parent: animation, curve: Curves.easeOutCubic),
              ),
          child: child,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final draft = ref.watch(characterDraftProvider);
    final notifier = ref.read(characterDraftProvider.notifier);

    final hasSelectedClass =
        draft.characterClass.isNotEmpty &&
        advancedClassDatabase.containsKey(draft.characterClass);

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (!hasSelectedClass) ...[
            Text(
              'Choose a Class',
              style: GoogleFonts.medievalSharp(
                fontSize: 22,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            ...advancedClassDatabase.values.map((characterClass) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 12.0),
                child: InkWell(
                  onTap: () => _openClassModal(context, characterClass, ref),
                  borderRadius: BorderRadius.circular(16),
                  child: GlassContainer(
                    padding: 16,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          characterClass.name,
                          style: GoogleFonts.medievalSharp(
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                        const Icon(Icons.chevron_right, color: Colors.white54),
                      ],
                    ),
                  ),
                ),
              );
            }),
          ] else ...[
            _buildSelectedClassView(draft.characterClass, notifier),
          ],
        ],
      ),
    );
  }

  Widget _buildSelectedClassView(String className, dynamic notifier) {
    final classData = advancedClassDatabase[className]!;

    // Dynamically grab the max value of the hit die (e.g., '1d10' -> '10')
    final baseHp = classData.hitDice.split('d').last;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Level 1 ${classData.name}',
                    style: GoogleFonts.medievalSharp(
                      fontSize: 32,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    classData.description,
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      color: Colors.white70,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
            TextButton(
              onPressed: () =>
                  notifier.updateClass(characterClass: '', level: 1),
              child: Text(
                'Change',
                style: GoogleFonts.inter(
                  color: Colors.lightBlueAccent,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),

        // NEW: Quick-Glance Core Mechanics Wrap
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            _buildStatChip(Icons.favorite, 'Base HP', '$baseHp + CON'),
            _buildStatChip(Icons.casino, 'Hit Dice', classData.hitDice),
            _buildStatChip(Icons.star, 'Primary', classData.primaryAbility),
            _buildStatChip(Icons.shield, 'Saves', classData.saves),
          ],
        ),

        const SizedBox(height: 24),

        // Level 1 Features
        Text(
          'Level 1 Features',
          style: GoogleFonts.medievalSharp(
            fontSize: 20,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        ...classData.level1Features.map(
          (feature) => ExpandableGlassTile(
            title: feature.name,
            description: feature.description,
          ),
        ),
      ],
    );
  }

  // Helper widget to build the sleek stat chips
  Widget _buildStatChip(IconData icon, String label, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: AppColors.royalPurple),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: GoogleFonts.inter(fontSize: 10, color: Colors.white54),
              ),
              Text(
                value,
                style: GoogleFonts.inter(
                  fontSize: 13,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// THE POP-UP LORE MODAL
class ClassDetailsModal extends StatelessWidget {
  final CharacterClass classData;
  final WidgetRef ref;

  const ClassDetailsModal({
    super.key,
    required this.classData,
    required this.ref,
  });

  @override
  Widget build(BuildContext context) {
    final baseHp = classData.hitDice.split('d').last;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Container(
          margin: const EdgeInsets.all(24),
          constraints: const BoxConstraints(maxHeight: 700),
          decoration: BoxDecoration(
            color: AppColors.midnightBlue,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.1),
              width: 1.5,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.8),
                blurRadius: 20,
                spreadRadius: 5,
              ),
            ],
          ),
          child: Column(
            children: [
              // Header
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.3),
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(20),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      classData.name,
                      style: GoogleFonts.medievalSharp(
                        fontSize: 28,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close, color: Colors.white54),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ],
                ),
              ),

              // Content
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        classData.description,
                        style: GoogleFonts.inter(
                          color: Colors.white70,
                          fontSize: 16,
                          height: 1.5,
                        ),
                      ),
                      const SizedBox(height: 24),

                      Text(
                        'Class Vitals',
                        style: GoogleFonts.medievalSharp(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),

                      // Using the same chip style in the modal for consistency!
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          _buildModalChip('Base HP', '$baseHp + CON'),
                          _buildModalChip('Hit Dice', classData.hitDice),
                          _buildModalChip('Primary', classData.primaryAbility),
                          _buildModalChip('Saves', classData.saves),
                        ],
                      ),

                      const Divider(color: Colors.white24, height: 40),

                      Text(
                        'Level 1 Features',
                        style: GoogleFonts.medievalSharp(
                          fontSize: 20,
                          color: AppColors.legendaryGold,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),
                      ...classData.level1Features.map(
                        (f) => _buildTraitRow(f.name, f.description),
                      ),
                    ],
                  ),
                ),
              ),

              // Footer
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.3),
                  borderRadius: const BorderRadius.vertical(
                    bottom: Radius.circular(20),
                  ),
                ),
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.royalPurple,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    ref
                        .read(characterDraftProvider.notifier)
                        .updateClass(characterClass: classData.name, level: 1);
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'Confirm Class',
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildModalChip(String label, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: GoogleFonts.inter(fontSize: 10, color: Colors.white54),
          ),
          Text(
            value,
            style: GoogleFonts.inter(
              fontSize: 13,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTraitRow(String title, String description) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.inter(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            description,
            style: GoogleFonts.inter(color: Colors.white70, height: 1.4),
          ),
        ],
      ),
    );
  }
}
