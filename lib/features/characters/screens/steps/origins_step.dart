import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/expandable_glass_tile.dart';
import '../../../../core/widgets/glass_container.dart';
import '../../data/mock_species_data.dart';
import '../../models/species.dart';
import '../../providers/character_draft_provider.dart';
import '../../widgets/character_avatar_picker.dart';

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

  void _openSpeciesModal(BuildContext context, Species speciesData) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: 'Dismiss',
      barrierColor: Colors.black.withValues(alpha: 0.6),
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (context, animation, secondaryAnimation) {
        return SpeciesDetailsModal(speciesData: speciesData);
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
  Widget build(BuildContext context) {
    final draft = ref.watch(characterDraftProvider);
    final notifier = ref.read(characterDraftProvider.notifier);
    final hasSelectedSpecies =
        draft.race.isNotEmpty &&
        advancedSpeciesDatabase.containsKey(draft.race);

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // 1. Avatar Picker
          Center(
            child: CharacterAvatarPicker(
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Image uploading unlocked in future update!'),
                    // TODO: Implement actual image upload and cropping functionality in a future update
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 32),

          // 2. Name Input
          TextFormField(
            controller: _nameController,
            style: GoogleFonts.inter(color: Colors.white, fontSize: 18),
            decoration: InputDecoration(
              labelText: 'Character Name',
              labelStyle: GoogleFonts.inter(color: Colors.white54),
              filled: true,
              fillColor: Colors.black.withValues(alpha: 0.3),
              contentPadding: const EdgeInsets.symmetric(
                vertical: 16,
                horizontal: 20,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(
                  color: AppColors.royalPurple,
                  width: 2,
                ),
              ),
            ),
            onChanged: (value) => notifier.updateName(value),
          ),
          const SizedBox(height: 32),

          // 3. Species Selection OR Selected View
          if (!hasSelectedSpecies) ...[
            Text(
              'Choose a Species',
              style: GoogleFonts.medievalSharp(
                fontSize: 22,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            ...advancedSpeciesDatabase.values.map((species) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 12.0),
                child: InkWell(
                  onTap: () => _openSpeciesModal(context, species),
                  borderRadius: BorderRadius.circular(16),
                  child: GlassContainer(
                    padding: 16,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          species.name,
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
            _buildSelectedSpeciesView(draft.race, draft.subrace, notifier),
          ],
        ],
      ),
    );
  }

  Widget _buildSelectedSpeciesView(
    String speciesName,
    String? subraceName,
    dynamic notifier,
  ) {
    final speciesData = advancedSpeciesDatabase[speciesName]!;

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
                    speciesData.name,
                    style: GoogleFonts.medievalSharp(
                      fontSize: 32,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    speciesData.description,
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
              onPressed: () => notifier.updateOrigins(race: '', subrace: ''),
              child: Text(
                'Change Species',
                style: GoogleFonts.inter(
                  color: Colors.lightBlueAccent,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),

        // Using our new Universal Reusable Widget!
        ExpandableGlassTile(title: 'Size', description: speciesData.size),
        ExpandableGlassTile(title: 'Speed', description: speciesData.speed),
        ...speciesData.traits.map(
          (trait) => ExpandableGlassTile(
            title: trait.name,
            description: trait.description,
          ),
        ),

        if (speciesData.lineages.isNotEmpty &&
            subraceName != null &&
            subraceName.isNotEmpty)
          ExpandableGlassTile(
            title: '${speciesData.lineageLabel}: $subraceName',
            description: speciesData.lineages[subraceName] ?? '',
            isHighlighted: true, // This triggers the legendaryGold color!
          ),
      ],
    );
  }
}

// THE POP-UP LORE MODAL
class SpeciesDetailsModal extends ConsumerStatefulWidget {
  final Species speciesData;
  const SpeciesDetailsModal({super.key, required this.speciesData});

  @override
  ConsumerState<SpeciesDetailsModal> createState() =>
      _SpeciesDetailsModalState();
}

class _SpeciesDetailsModalState extends ConsumerState<SpeciesDetailsModal> {
  String? _selectedLineage;

  @override
  Widget build(BuildContext context) {
    final bool requiresLineage = widget.speciesData.lineages.isNotEmpty;
    final bool canConfirm = !requiresLineage || (_selectedLineage != null);

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
                      widget.speciesData.name,
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
                        widget.speciesData.description,
                        style: GoogleFonts.inter(
                          color: Colors.white70,
                          fontSize: 16,
                          height: 1.5,
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Lineage Selection
                      if (requiresLineage) ...[
                        Text(
                          'Choose a ${widget.speciesData.lineageLabel}',
                          style: GoogleFonts.medievalSharp(
                            fontSize: 20,
                            color: AppColors.royalPurple,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 12),
                        ...widget.speciesData.lineages.entries.map((entry) {
                          final isSelected = _selectedLineage == entry.key;
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: InkWell(
                              onTap: () =>
                                  setState(() => _selectedLineage = entry.key),
                              borderRadius: BorderRadius.circular(12),
                              child: Container(
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? AppColors.royalPurple.withValues(
                                          alpha: 0.2,
                                        )
                                      : Colors.white.withValues(alpha: 0.05),
                                  border: Border.all(
                                    color: isSelected
                                        ? AppColors.royalPurple
                                        : Colors.transparent,
                                  ),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(
                                          isSelected
                                              ? Icons.radio_button_checked
                                              : Icons.radio_button_unchecked,
                                          color: isSelected
                                              ? AppColors.royalPurple
                                              : Colors.white54,
                                          size: 20,
                                        ),
                                        const SizedBox(width: 12),
                                        Text(
                                          entry.key,
                                          style: GoogleFonts.inter(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      entry.value,
                                      style: GoogleFonts.inter(
                                        color: Colors.white70,
                                        fontSize: 13,
                                        height: 1.4,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }),
                        const Divider(color: Colors.white24, height: 40),
                      ],

                      // Traits
                      Text(
                        'Species Traits',
                        style: GoogleFonts.medievalSharp(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),
                      _buildTraitRow('Size', widget.speciesData.size),
                      _buildTraitRow('Speed', widget.speciesData.speed),
                      ...widget.speciesData.traits.map(
                        (t) => _buildTraitRow(t.name, t.description),
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
                    disabledBackgroundColor: Colors.grey.shade800,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: canConfirm
                      ? () {
                          ref
                              .read(characterDraftProvider.notifier)
                              .updateOrigins(
                                race: widget.speciesData.name,
                                subrace: _selectedLineage ?? '',
                              );
                          Navigator.of(context).pop();
                        }
                      : null,
                  child: Text(
                    'Confirm Species',
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
