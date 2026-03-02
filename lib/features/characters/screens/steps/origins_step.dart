import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/glass_container.dart';
import '../../providers/character_draft_provider.dart';
import '../../widgets/character_avatar_picker.dart';

// --- 5e Lore Database ---
const Map<String, List<String>> raceData = {
  'Dwarf': ['Hill Dwarf', 'Mountain Dwarf'],
  'Elf': ['High Elf', 'Wood Elf', 'Drow'],
  'Halfling': ['Lightfoot', 'Stout'],
  'Human': ['Standard', 'Variant'],
  'Dragonborn': [],
  'Tiefling': [],
};

const Map<String, String> raceDescriptions = {
  'Dwarf':
      'Bold and hardy, dwarves are known as skilled warriors, miners, and workers of stone and metal.',
  'Elf':
      'Elves are a magical people of otherworldly grace, living in the world but not entirely part of it.',
  'Halfling':
      'The diminutive halflings survive in a world full of larger creatures by avoiding notice or, barring that, avoiding offense.',
  'Human':
      'Humans are the most adaptable and ambitious people among the common races. Whatever drives them, humans are the innovators.',
  'Dragonborn':
      'Dragonborn look very much like dragons standing erect in humanoid form, though they lack wings or a tail.',
  'Tiefling':
      'To be greeted with stares and whispers, to suffer violence and insult on the street: this is the lot of the tiefling.',
};

const Map<String, String> subraceDescriptions = {
  'Hill Dwarf':
      'You have keen senses, deep intuition, and remarkable resilience. Your hit point maximum increases by 1.',
  'Mountain Dwarf':
      'You’re strong and hardy, accustomed to a difficult life in rugged terrain. You have proficiency with light and medium armor.',
  'High Elf':
      'You have a keen mind and a mastery of at least the basics of magic. You know one cantrip of your choice from the wizard spell list.',
  'Wood Elf':
      'You have keen senses and intuition, and your fleet feet carry you quickly and stealthily through your native forests.',
  'Drow':
      'Descended from an earlier subrace of elves, the drow were banished from the surface world. You have superior darkvision and drow magic.',
  'Lightfoot':
      'You can easily hide from notice, even using other people as cover. You’re inclined to be affable and get along well with others.',
  'Stout':
      'You’re hardier than average and have some resistance to poison. Some say that stouts have dwarven blood.',
  'Standard': 'You increase all of your ability scores by 1.',
  'Variant':
      'You gain one feat of your choice and proficiency in one skill of your choice.',
};

class OriginsStep extends ConsumerStatefulWidget {
  const OriginsStep({super.key});

  @override
  ConsumerState<OriginsStep> createState() => _OriginsStepState();
}

class _OriginsStepState extends ConsumerState<OriginsStep> {
  late TextEditingController _nameController;

  @override
  void initState() {
    super.initState();
    final draft = ref.read(characterDraftProvider);
    _nameController = TextEditingController(text: draft.name);
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final draft = ref.watch(characterDraftProvider);
    final notifier = ref.read(characterDraftProvider.notifier);

    final List<String> availableSubraces = draft.race.isNotEmpty
        ? (raceData[draft.race] ?? <String>[])
        : <String>[];

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // 1. Avatar Picker (Centered)
          Center(
            child: CharacterAvatarPicker(
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      'Image uploading will be unlocked in a future update!',
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 32),

          // 2. The Identity Glass Container
          GlassContainer(
            padding: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Hero\'s Identity',
                  style: GoogleFonts.medievalSharp(
                    fontSize: 22,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _nameController,
                  style: GoogleFonts.inter(color: Colors.white, fontSize: 18),
                  decoration: _buildInputDecoration(
                    'Character Name',
                    Icons.badge,
                  ),
                  onChanged: (value) => notifier.updateName(value),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // 3. The Lineage Glass Container (Race & Subrace combined)
          GlassContainer(
            padding: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Bloodline & Lineage',
                  style: GoogleFonts.medievalSharp(
                    fontSize: 22,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),

                // --- Race Selection ---
                DropdownButtonFormField<String>(
                  initialValue: draft.race.isEmpty ? null : draft.race,
                  dropdownColor: AppColors.charcoal,
                  style: GoogleFonts.inter(color: Colors.white, fontSize: 16),
                  decoration: _buildInputDecoration('Race', Icons.groups),
                  items: raceData.keys.map((race) {
                    return DropdownMenuItem<String>(
                      value: race,
                      child: Text(race),
                    );
                  }).toList(),
                  onChanged: (value) {
                    if (value != null) {
                      notifier.updateOrigins(race: value, subrace: '');
                    }
                  },
                ),

                // Dynamic Race Lore
                if (draft.race.isNotEmpty &&
                    raceDescriptions.containsKey(draft.race))
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 12.0,
                      bottom: 8.0,
                      left: 4.0,
                    ),
                    child: Text(
                      raceDescriptions[draft.race]!,
                      style: GoogleFonts.inter(
                        color: Colors.white70,
                        fontStyle: FontStyle.italic,
                        fontSize: 14,
                        height: 1.4,
                      ),
                    ),
                  ),

                // --- Subrace Selection (Only if race has subraces) ---
                if (availableSubraces.isNotEmpty) ...[
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 16.0),
                    child: Divider(color: Colors.white24, height: 1),
                  ),
                  DropdownButtonFormField<String>(
                    initialValue:
                        draft.subrace == null ||
                            draft.subrace!.isEmpty ||
                            !availableSubraces.contains(draft.subrace)
                        ? null
                        : draft.subrace,
                    dropdownColor: AppColors.charcoal,
                    style: GoogleFonts.inter(color: Colors.white, fontSize: 16),
                    decoration: _buildInputDecoration(
                      'Subrace',
                      Icons.account_tree,
                    ),
                    items: availableSubraces.map((subrace) {
                      return DropdownMenuItem<String>(
                        value: subrace,
                        child: Text(subrace),
                      );
                    }).toList(),
                    onChanged: (value) =>
                        notifier.updateOrigins(subrace: value),
                  ),

                  // Dynamic Subrace Lore
                  if (draft.subrace != null &&
                      draft.subrace!.isNotEmpty &&
                      subraceDescriptions.containsKey(draft.subrace))
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 12.0,
                        bottom: 4.0,
                        left: 4.0,
                      ),
                      child: Text(
                        subraceDescriptions[draft.subrace]!,
                        style: GoogleFonts.inter(
                          color: AppColors.royalPurple.withValues(alpha: 0.9),
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          height: 1.4,
                        ),
                      ),
                    ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Refined input decoration to match the Glass aesthetic
  InputDecoration _buildInputDecoration(String label, IconData icon) {
    return InputDecoration(
      labelText: label,
      labelStyle: GoogleFonts.inter(color: Colors.white54),
      prefixIcon: Icon(icon, color: AppColors.royalPurple),
      filled: true,
      fillColor: Colors.black.withValues(alpha: 0.2), // Darker inset for inputs
      contentPadding: const EdgeInsets.symmetric(vertical: 16),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.white.withValues(alpha: 0.1)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(
          color: AppColors.royalPurple.withValues(alpha: 0.8),
          width: 2,
        ),
      ),
    );
  }
}
