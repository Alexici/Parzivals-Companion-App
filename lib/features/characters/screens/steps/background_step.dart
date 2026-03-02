import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/glass_container.dart';
import '../../data/mock_background_data.dart';
import '../../providers/character_draft_provider.dart';

const List<String> alignmentOptions = [
  'Lawful Good',
  'Neutral Good',
  'Chaotic Good',
  'Lawful Neutral',
  'True Neutral',
  'Chaotic Neutral',
  'Lawful Evil',
  'Neutral Evil',
  'Chaotic Evil',
];

const List<String> genderOptions = ['Male', 'Female', 'Non-binary', 'Other'];

class BackgroundStep extends ConsumerStatefulWidget {
  const BackgroundStep({super.key});

  @override
  ConsumerState<BackgroundStep> createState() => _BackgroundStepState();
}

class _BackgroundStepState extends ConsumerState<BackgroundStep> {
  // We declare controllers for all the text inputs to prevent cursor jumping
  late TextEditingController _customTitleCtrl;
  late TextEditingController _customDescCtrl;
  late TextEditingController _ageCtrl, _heightCtrl, _weightCtrl;
  late TextEditingController _eyesCtrl, _skinCtrl, _hairCtrl;
  late TextEditingController _personalityCtrl,
      _idealsCtrl,
      _bondsCtrl,
      _flawsCtrl,
      _backstoryCtrl;

  @override
  void initState() {
    super.initState();
    final draft = ref.read(characterDraftProvider);
    _customTitleCtrl = TextEditingController(text: draft.customBackgroundName);
    _customDescCtrl = TextEditingController(
      text: draft.customBackgroundDescription,
    );
    _ageCtrl = TextEditingController(text: draft.age);
    _heightCtrl = TextEditingController(text: draft.height);
    _weightCtrl = TextEditingController(text: draft.weight);
    _eyesCtrl = TextEditingController(text: draft.eyes);
    _skinCtrl = TextEditingController(text: draft.skin);
    _hairCtrl = TextEditingController(text: draft.hair);
    _personalityCtrl = TextEditingController(text: draft.personalityTraits);
    _idealsCtrl = TextEditingController(text: draft.ideals);
    _bondsCtrl = TextEditingController(text: draft.bonds);
    _flawsCtrl = TextEditingController(text: draft.flaws);
    _backstoryCtrl = TextEditingController(text: draft.backstory);
  }

  @override
  void dispose() {
    _customTitleCtrl.dispose();
    _customDescCtrl.dispose();
    _ageCtrl.dispose();
    _heightCtrl.dispose();
    _weightCtrl.dispose();
    _eyesCtrl.dispose();
    _skinCtrl.dispose();
    _hairCtrl.dispose();
    _personalityCtrl.dispose();
    _idealsCtrl.dispose();
    _bondsCtrl.dispose();
    _flawsCtrl.dispose();
    _backstoryCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final draft = ref.watch(characterDraftProvider);
    final notifier = ref.read(characterDraftProvider.notifier);

    // Build the dropdown list (2024 PHB Backgrounds + "Custom")
    final backgroundOptions = [...advancedBackgroundDatabase.keys, 'Custom'];

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // ==========================================
          // 1. ORIGIN & BACKGROUND
          // ==========================================
          Text(
            'Past & Profession',
            style: GoogleFonts.medievalSharp(
              fontSize: 26,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),

          GlassContainer(
            padding: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DropdownButtonFormField<String>(
                  initialValue: draft.background.isEmpty
                      ? null
                      : draft.background,
                  dropdownColor: AppColors.midnightBlue,
                  style: GoogleFonts.inter(color: Colors.white, fontSize: 16),
                  decoration: _buildInputDecoration(
                    'Background',
                    Icons.history_edu,
                  ),
                  items: backgroundOptions
                      .map((bg) => DropdownMenuItem(value: bg, child: Text(bg)))
                      .toList(),
                  onChanged: (value) =>
                      notifier.updateBackgroundDetails(background: value),
                ),

                const SizedBox(height: 16),

                // DYNAMIC BACKGROUND RENDERER
                if (draft.background == 'Custom') ...[
                  TextFormField(
                    controller: _customTitleCtrl,
                    style: GoogleFonts.inter(color: Colors.white),
                    decoration: _buildInputDecoration(
                      'Custom Background Name',
                      Icons.edit,
                    ),
                    onChanged: (val) => notifier.updateBackgroundDetails(
                      customBackgroundName: val,
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _customDescCtrl,
                    style: GoogleFonts.inter(color: Colors.white),
                    maxLines: 3,
                    decoration: _buildInputDecoration(
                      'Description',
                      Icons.description,
                    ),
                    onChanged: (val) => notifier.updateBackgroundDetails(
                      customBackgroundDescription: val,
                    ),
                  ),
                ] else if (draft.background.isNotEmpty &&
                    advancedBackgroundDatabase.containsKey(
                      draft.background,
                    )) ...[
                  Text(
                    advancedBackgroundDatabase[draft.background]!.description,
                    style: GoogleFonts.inter(
                      color: Colors.white70,
                      height: 1.5,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(height: 32),

          // ==========================================
          // 2. IDENTITY & PHYSIQUE (Gender moved here!)
          // ==========================================
          Text(
            'Identity & Physique',
            style: GoogleFonts.medievalSharp(
              fontSize: 26,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),

          GlassContainer(
            padding: 20,
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: DropdownButtonFormField<String>(
                        initialValue: draft.alignment.isEmpty
                            ? null
                            : draft.alignment,
                        dropdownColor: AppColors.midnightBlue,
                        style: GoogleFonts.inter(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                        decoration: _buildInputDecoration(
                          'Alignment',
                          Icons.balance,
                        ),
                        items: alignmentOptions
                            .map(
                              (a) => DropdownMenuItem(value: a, child: Text(a)),
                            )
                            .toList(),
                        onChanged: (val) =>
                            notifier.updateBackgroundDetails(alignment: val),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: DropdownButtonFormField<String>(
                        initialValue: draft.gender.isEmpty
                            ? null
                            : draft.gender,
                        dropdownColor: AppColors.midnightBlue,
                        style: GoogleFonts.inter(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                        decoration: _buildInputDecoration(
                          'Gender',
                          Icons.transgender,
                        ),
                        items: genderOptions
                            .map(
                              (g) => DropdownMenuItem(value: g, child: Text(g)),
                            )
                            .toList(),
                        onChanged: (val) =>
                            notifier.updateBackgroundDetails(gender: val),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // 3-Column Grid for physical stats
                Row(
                  children: [
                    Expanded(
                      child: _buildTextField(
                        _ageCtrl,
                        'Age',
                        notifier.updateBackgroundDetails,
                        isNumber: true,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: _buildTextField(
                        _heightCtrl,
                        'Height',
                        notifier.updateBackgroundDetails,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: _buildTextField(
                        _weightCtrl,
                        'Weight',
                        notifier.updateBackgroundDetails,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: _buildTextField(
                        _eyesCtrl,
                        'Eyes',
                        notifier.updateBackgroundDetails,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: _buildTextField(
                        _skinCtrl,
                        'Skin',
                        notifier.updateBackgroundDetails,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: _buildTextField(
                        _hairCtrl,
                        'Hair',
                        notifier.updateBackgroundDetails,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),

          // ==========================================
          // 3. PERSONALITY & LORE
          // ==========================================
          Text(
            'Personality & Lore',
            style: GoogleFonts.medievalSharp(
              fontSize: 26,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),

          GlassContainer(
            padding: 20,
            child: Column(
              children: [
                _buildTextArea(
                  _personalityCtrl,
                  'Personality Traits',
                  (val) =>
                      notifier.updateBackgroundDetails(personalityTraits: val),
                ),
                const SizedBox(height: 12),
                _buildTextArea(
                  _idealsCtrl,
                  'Ideals',
                  (val) => notifier.updateBackgroundDetails(ideals: val),
                ),
                const SizedBox(height: 12),
                _buildTextArea(
                  _bondsCtrl,
                  'Bonds',
                  (val) => notifier.updateBackgroundDetails(bonds: val),
                ),
                const SizedBox(height: 12),
                _buildTextArea(
                  _flawsCtrl,
                  'Flaws',
                  (val) => notifier.updateBackgroundDetails(flaws: val),
                ),
                const SizedBox(height: 16),
                const Divider(color: Colors.white24),
                const SizedBox(height: 16),
                _buildTextArea(
                  _backstoryCtrl,
                  'Character Backstory',
                  (val) => notifier.updateBackgroundDetails(backstory: val),
                  lines: 5,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // --- Helper Widgets to keep code clean ---

  Widget _buildTextField(
    TextEditingController controller,
    String label,
    Function updateFn, {
    bool isNumber = false,
  }) {
    return TextFormField(
      controller: controller,
      style: GoogleFonts.inter(color: Colors.white, fontSize: 14),
      keyboardType: isNumber ? TextInputType.number : TextInputType.text,
      decoration: _buildInputDecoration(label, null),
      onChanged: (val) {
        if (label == 'Age') updateFn(age: val);
        if (label == 'Height') updateFn(height: val);
        if (label == 'Weight') updateFn(weight: val);
        if (label == 'Eyes') updateFn(eyes: val);
        if (label == 'Skin') updateFn(skin: val);
        if (label == 'Hair') updateFn(hair: val);
      },
    );
  }

  Widget _buildTextArea(
    TextEditingController controller,
    String label,
    Function(String) onChanged, {
    int lines = 3,
  }) {
    return TextFormField(
      controller: controller,
      style: GoogleFonts.inter(color: Colors.white, fontSize: 14),
      maxLines: lines,
      decoration: _buildInputDecoration(label, null),
      onChanged: onChanged,
    );
  }

  InputDecoration _buildInputDecoration(String label, IconData? icon) {
    return InputDecoration(
      labelText: label,
      labelStyle: GoogleFonts.inter(color: Colors.white54, fontSize: 14),
      prefixIcon: icon != null
          ? Icon(icon, color: AppColors.royalPurple, size: 20)
          : null,
      filled: true,
      fillColor: Colors.black.withValues(alpha: 0.2),
      contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.white.withValues(alpha: 0.1)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.royalPurple, width: 2),
      ),
    );
  }
}
