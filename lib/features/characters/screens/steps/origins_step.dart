import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/glass_container.dart';
import '../../providers/character_draft_provider.dart';
import '../../widgets/character_avatar_picker.dart';

// ==========================================
// 1. 2024 D&D 5E SPECIES DATABASE
// ==========================================
class SpeciesTrait {
  final String name;
  final String description;
  const SpeciesTrait(this.name, this.description);
}

class SpeciesData {
  final String name;
  final String description;
  final String size;
  final String speed;
  final List<SpeciesTrait> traits;
  final Map<String, String> lineages; // Name : Description
  final String lineageLabel;

  const SpeciesData({
    required this.name,
    required this.description,
    required this.size,
    required this.speed,
    required this.traits,
    required this.lineages,
    this.lineageLabel = 'Lineage',
  });
}

const Map<String, SpeciesData> advancedSpeciesDatabase = {
  'Dragonborn': SpeciesData(
    name: 'Dragonborn',
    description:
        'Dragonborn look very much like dragons standing erect in humanoid form, though they lack wings or a tail.',
    size: 'Medium',
    speed: '30 ft.',
    lineageLabel: 'Draconic Ancestry',
    traits: [
      SpeciesTrait(
        'Darkvision',
        'You can see in dim light and darkness up to 60 feet.',
      ),
      SpeciesTrait(
        'Breath Weapon',
        'When you take the Attack action, you can replace one of your attacks with an exhalation of magical energy in a 15-foot cone or 30-foot line.',
      ),
      SpeciesTrait(
        'Draconic Flight',
        'At level 5, as a Bonus Action, you can sprout spectral wings and gain a Fly Speed equal to your Speed for 10 minutes.',
      ),
    ],
    lineages: {
      'Black':
          'Your Breath Weapon and Damage Resistance are tied to Acid damage.',
      'Blue':
          'Your Breath Weapon and Damage Resistance are tied to Lightning damage.',
      'Brass':
          'Your Breath Weapon and Damage Resistance are tied to Fire damage.',
      'Bronze':
          'Your Breath Weapon and Damage Resistance are tied to Lightning damage.',
      'Copper':
          'Your Breath Weapon and Damage Resistance are tied to Acid damage.',
      'Gold':
          'Your Breath Weapon and Damage Resistance are tied to Fire damage.',
      'Green':
          'Your Breath Weapon and Damage Resistance are tied to Poison damage.',
      'Red':
          'Your Breath Weapon and Damage Resistance are tied to Fire damage.',
      'Silver':
          'Your Breath Weapon and Damage Resistance are tied to Cold damage.',
      'White':
          'Your Breath Weapon and Damage Resistance are tied to Cold damage.',
    },
  ),
  'Dwarf': SpeciesData(
    name: 'Dwarf',
    description:
        'Bold and hardy, dwarves are known as skilled warriors, miners, and workers of stone and metal.',
    size: 'Medium',
    speed: '30 ft.',
    traits: [
      SpeciesTrait(
        'Darkvision',
        'You have superior vision in dark and dim conditions, up to 120 feet.',
      ),
      SpeciesTrait(
        'Dwarven Resilience',
        'You have Resistance to Poison damage and Advantage on saving throws against the Poisoned condition.',
      ),
      SpeciesTrait(
        'Dwarven Toughness',
        'Your Hit Point maximum increases by 1, and it increases by 1 every time you gain a level.',
      ),
      SpeciesTrait(
        'Stonecunning',
        'As a Bonus Action, you gain Tremorsense with a range of 60 feet for 10 minutes. You must be on a stone surface or touching one.',
      ),
    ],
    lineages: {},
  ),
  'Elf': SpeciesData(
    name: 'Elf',
    description:
        'Elves are a magical people of otherworldly grace, living in the world but not entirely part of it.',
    size: 'Medium',
    speed: '30 ft.',
    traits: [
      SpeciesTrait(
        'Darkvision',
        'You can see in dim light and darkness up to 60 feet.',
      ),
      SpeciesTrait(
        'Fey Ancestry',
        'You have Advantage on saving throws to prevent or end the Charmed condition on yourself.',
      ),
      SpeciesTrait(
        'Keen Senses',
        'You have proficiency in the Insight, Perception, or Survival skill.',
      ),
      SpeciesTrait(
        'Trance',
        'You don’t need to sleep, and magic can’t put you to sleep. You can finish a Long Rest in 4 hours if you spend those hours in a trancelike meditation.',
      ),
    ],
    lineages: {
      'Drow':
          'Your Darkvision range increases to 120 ft. You know the Dancing Lights cantrip. At higher levels, you learn Faerie Fire and Darkness.',
      'High Elf':
          'You know the Prestidigitation cantrip and can swap it for another Wizard cantrip after a Long Rest. At higher levels, you learn Detect Magic and Misty Step.',
      'Wood Elf':
          'Your Speed increases to 35 ft. You know the Druidcraft cantrip. At higher levels, you learn Longstrider and Pass Without Trace.',
    },
  ),
  'Gnome': SpeciesData(
    name: 'Gnome',
    description:
        'Gnomes are small, secretive, and clever humanoids known for their vibrant curiosity and magical aptitude.',
    size: 'Small',
    speed: '30 ft.',
    traits: [
      SpeciesTrait(
        'Darkvision',
        'You can see in dim light and darkness up to 60 feet.',
      ),
      SpeciesTrait(
        'Gnomish Cunning',
        'You have Advantage on Intelligence, Wisdom, and Charisma saving throws.',
      ),
    ],
    lineages: {
      'Forest Gnome':
          'You know the Minor Illusion cantrip. You always have the Speak with Animals spell prepared and can cast it without a spell slot.',
      'Rock Gnome':
          'You know the Mending and Prestidigitation cantrips. You can use Prestidigitation to create tiny clockwork devices.',
    },
  ),
  'Goliath': SpeciesData(
    name: 'Goliath',
    description:
        'Goliaths are massive humanoids who trace their ancestry back to the giants of the ancient world.',
    size: 'Medium',
    speed: '35 ft.',
    lineageLabel: 'Giant Ancestry',
    traits: [
      SpeciesTrait(
        'Powerful Build',
        'You have Advantage on any ability check you make to end the Grappled condition. You count as one size larger when determining your carrying capacity.',
      ),
      SpeciesTrait(
        'Large Form',
        'At level 5, as a Bonus Action, you can change your size to Large for 10 minutes. You gain Advantage on Strength checks and your Speed increases by 10 feet.',
      ),
    ],
    lineages: {
      'Cloud Giant':
          'You can magically teleport up to 30 feet to an unoccupied space you can see.',
      'Fire Giant':
          'You can deal extra Fire damage when you hit with an attack.',
      'Frost Giant':
          'You can deal extra Cold damage and reduce the target\'s Speed to 0.',
      'Hill Giant':
          'You can knock a Large or smaller creature Prone when you hit them.',
      'Stone Giant':
          'You can use your Reaction to reduce bludgeoning, piercing, or slashing damage you take.',
      'Storm Giant':
          'You can use your Reaction to deal Lightning damage to a creature that hits you.',
    },
  ),
  'Halfling': SpeciesData(
    name: 'Halfling',
    description:
        'Halflings are small, cheerful, and curious people who easily survive in a world full of larger creatures.',
    size: 'Small',
    speed: '30 ft.',
    traits: [
      SpeciesTrait(
        'Brave',
        'You have Advantage on saving throws against or to end the Frightened condition.',
      ),
      SpeciesTrait(
        'Halfling Nimbleness',
        'You can move through the space of any creature that is of a size larger than yours.',
      ),
      SpeciesTrait(
        'Luck',
        'When you roll a 1 on the d20 of a d20 Test, you can reroll the die, and you must use the new roll.',
      ),
      SpeciesTrait(
        'Naturally Stealthy',
        'You can take the Hide action even when you are obscured only by a creature that is at least one size larger than you.',
      ),
    ],
    lineages: {},
  ),
  'Human': SpeciesData(
    name: 'Human',
    description:
        'Humans are the most adaptable and ambitious people among the common species, known for their versatility.',
    size: 'Medium or Small',
    speed: '30 ft.',
    traits: [
      SpeciesTrait(
        'Resourceful',
        'You gain Heroic Inspiration whenever you finish a Long Rest.',
      ),
      SpeciesTrait(
        'Skillful',
        'You gain proficiency in one skill of your choice.',
      ),
      SpeciesTrait('Versatile', 'You gain an Origin Feat of your choice.'),
    ],
    lineages: {},
  ),
  'Orc': SpeciesData(
    name: 'Orc',
    description:
        'Built for brawn and endurance, Orcs are naturally muscular and boast a relentless drive to survive.',
    size: 'Medium',
    speed: '30 ft.',
    traits: [
      SpeciesTrait(
        'Darkvision',
        'You can see in dim light and darkness up to 120 feet.',
      ),
      SpeciesTrait(
        'Adrenaline Rush',
        'You can take the Dash action as a Bonus Action. When you do, you gain Temporary Hit Points equal to your Proficiency Bonus.',
      ),
      SpeciesTrait(
        'Relentless Endurance',
        'When you are reduced to 0 Hit Points but not killed outright, you can drop to 1 Hit Point instead. Once per Long Rest.',
      ),
    ],
    lineages: {},
  ),
  'Tiefling': SpeciesData(
    name: 'Tiefling',
    description:
        'To be greeted with stares and whispers, to suffer violence and insult on the street: this is the lot of the tiefling.',
    size: 'Medium or Small',
    speed: '30 ft.',
    lineageLabel: 'Fiendish Legacy',
    traits: [
      SpeciesTrait(
        'Darkvision',
        'You can see in dim light and darkness up to 60 feet.',
      ),
      SpeciesTrait(
        'Otherworldly Presence',
        'You know the Thaumaturgy cantrip.',
      ),
    ],
    lineages: {
      'Abyssal':
          'You have Resistance to Poison damage. You know the Poison Spray cantrip. At higher levels, you learn Ray of Sickness and Hold Person.',
      'Chthonic':
          'You have Resistance to Necrotic damage. You know the Chill Touch cantrip. At higher levels, you learn False Life and Ray of Enfeeblement.',
      'Infernal':
          'You have Resistance to Fire damage. You know the Fire Bolt cantrip. At higher levels, you learn Hellish Rebuke and Darkness.',
    },
  ),
};

// ==========================================
// 2. MAIN SCREEN UI
// ==========================================
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

  void _openSpeciesModal(BuildContext context, SpeciesData speciesData) {
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

    // Using draft.race behind the scenes to store the Species choice
    final hasSelectedSpecies =
        draft.race.isNotEmpty &&
        advancedSpeciesDatabase.containsKey(draft.race);

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Avatar Picker
          Center(
            child: CharacterAvatarPicker(
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Image uploading unlocked in future update!'),
                    // TODO: Implement actual image picking and uploading functionality in a future update
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 32),

          // Name Input
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
                borderSide: BorderSide(
                  color: AppColors.royalPurple.withValues(alpha: 0.8),
                  width: 2,
                ),
              ),
            ),
            onChanged: (value) => notifier.updateName(value),
          ),
          const SizedBox(height: 32),

          // --- DYNAMIC SPECIES SECTION ---
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

            // The List of Available Species
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
            // The D&D Beyond Selected View
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
                  const SizedBox(height: 12),
                  Text(
                    'Traits: ${speciesData.traits.map((t) => t.name).join(', ')}${speciesData.lineages.isNotEmpty ? ', ${speciesData.lineageLabel}' : ''}',
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      color: Colors.white54,
                      fontStyle: FontStyle.italic,
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

        // Expandable Trait Tiles
        _buildExpandableTrait('Size', speciesData.size),
        _buildExpandableTrait('Speed', speciesData.speed),
        ...speciesData.traits.map(
          (trait) => _buildExpandableTrait(trait.name, trait.description),
        ),

        // Selected Lineage/Ancestry Tile
        if (speciesData.lineages.isNotEmpty &&
            subraceName != null &&
            subraceName.isNotEmpty)
          _buildExpandableTrait(
            '${speciesData.lineageLabel}: $subraceName',
            speciesData.lineages[subraceName] ?? '',
            isHighlighted: true,
          ),
      ],
    );
  }

  Widget _buildExpandableTrait(
    String title,
    String description, {
    bool isHighlighted = false,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: GlassContainer(
        padding: 0,
        child: Theme(
          data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
          child: ExpansionTile(
            title: Text(
              title,
              style: GoogleFonts.openSans(
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
                style: GoogleFonts.openSans(color: Colors.white70, height: 1.5),
                textAlign: TextAlign.left,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ==========================================
// 3. THE POP-UP LORE MODAL
// ==========================================
class SpeciesDetailsModal extends ConsumerStatefulWidget {
  final SpeciesData speciesData;
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

              // Scrollable Content
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

                      // Lineage Selection (If applicable)
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

                      // Base Traits
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

              // Confirm Button Footer
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
                          // Update Riverpod State
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
