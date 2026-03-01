import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/app_colors.dart';
import '../../providers/character_draft_provider.dart';
import '../../widgets/character_avatar_picker.dart';

// 5e Database Maps
const Map<String, List<String>> raceData = {
  'Dwarf': ['Hill Dwarf', 'Mountain Dwarf'],
  'Elf': ['High Elf', 'Wood Elf', 'Drow'],
  'Halfling': ['Lightfoot', 'Stout'],
  'Human': ['Standard', 'Variant'],
  'Dragonborn': [],
  'Tiefling': [],
};

const List<String> genderOptions = ['Male', 'Female'];

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
    // Grab the name from the clipboard if they swiped back to this page
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
    // Watch the clipboard for dropdown updates
    final draft = ref.watch(characterDraftProvider);
    final notifier = ref.read(characterDraftProvider.notifier);

    // Get available subraces based on currently selected race
    final List<String> availableSubraces = draft.race.isNotEmpty
        ? (raceData[draft.race] ?? <String>[])
        : <String>[];
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // 1. Modular Avatar Picker
          CharacterAvatarPicker(
            onTap: () {
              // TODO: Phase 4 - Open Image Picker
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                    'Image uploading will be unlocked in a future update!',
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 32),

          // 2. Character Name Input
          TextFormField(
            controller: _nameController,
            style: const TextStyle(color: Colors.white),
            decoration: _buildInputDecoration('Character Name', Icons.badge),
            onChanged: (value) => notifier.updateName(value),
          ),
          const SizedBox(height: 24),

          // 3. Race Dropdown
          DropdownButtonFormField<String>(
            initialValue: draft.race.isEmpty ? null : draft.race,
            dropdownColor: AppColors.charcoal,
            style: const TextStyle(color: Colors.white),
            decoration: _buildInputDecoration('Race', Icons.groups),
            items: raceData.keys.map((race) {
              return DropdownMenuItem<String>(value: race, child: Text(race));
            }).toList(),
            onChanged: (value) {
              if (value != null) {
                notifier.updateOrigins(race: value, subrace: '');
              }
            },
          ),
          const SizedBox(height: 24),

          // 4. Subrace Dropdown
          DropdownButtonFormField<String>(
            initialValue:
                draft.subrace == null ||
                    draft.subrace!.isEmpty ||
                    !availableSubraces.contains(draft.subrace)
                ? null
                : draft.subrace,
            dropdownColor: AppColors.charcoal,
            style: const TextStyle(color: Colors.white),
            decoration: _buildInputDecoration('Subrace', Icons.account_tree),
            items: availableSubraces.isEmpty
                ? null
                : availableSubraces.map((subrace) {
                    return DropdownMenuItem<String>(
                      value: subrace,
                      child: Text(subrace),
                    );
                  }).toList(),
            onChanged: availableSubraces.isEmpty
                ? null
                : (value) => notifier.updateOrigins(subrace: value),
          ),
          const SizedBox(height: 24),

          // 5. Gender Dropdown
          DropdownButtonFormField<String>(
            initialValue: draft.gender.isEmpty ? null : draft.gender,
            dropdownColor: AppColors.charcoal,
            style: const TextStyle(color: Colors.white),
            decoration: _buildInputDecoration('Gender', Icons.transgender),
            items: genderOptions.map((gender) {
              return DropdownMenuItem<String>(
                value: gender,
                child: Text(gender),
              );
            }).toList(),
            onChanged: (value) => notifier.updateOrigins(gender: value),
          ),
        ],
      ),
    );
  }

  // A quick helper to make our inputs look unified and glassy
  InputDecoration _buildInputDecoration(String label, IconData icon) {
    return InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(color: Colors.white54),
      prefixIcon: Icon(icon, color: AppColors.royalPurple),
      filled: true,
      fillColor: Colors.white.withValues(alpha: 0.05),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.white.withValues(alpha: 0.1)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(
          color: AppColors.royalPurple.withValues(alpha: 0.8),
        ),
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.white.withValues(alpha: 0.02)),
      ),
    );
  }
}
