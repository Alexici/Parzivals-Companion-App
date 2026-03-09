import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';

// --- Theme & Core ---
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/app_snackbars.dart';

// --- Providers & Utilities ---
import '../repositories/character_repository.dart';
import '../utils/character_forge.dart';
import '../providers/character_draft_provider.dart';

// --- The 5 Wizard Steps ---
import 'steps/origins_step.dart';
import 'steps/class_step.dart';
import 'steps/background_step.dart';
import 'steps/abilities_step.dart';
import 'steps/equipment_step.dart';

class CharacterCreationScreen extends ConsumerStatefulWidget {
  const CharacterCreationScreen({super.key});

  @override
  ConsumerState<CharacterCreationScreen> createState() =>
      _CharacterCreationScreenState();
}

class _CharacterCreationScreenState
    extends ConsumerState<CharacterCreationScreen> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;
  final int _totalPages = 5;

  final List<String> _stepTitles = [
    'Origins & Identity',
    'Class Selection',
    'Background & Details',
    'Ability Scores',
    'Starting Equipment',
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _previousPage() {
    if (_currentIndex > 0) {
      _pageController.animateToPage(
        _currentIndex - 1,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      // If they press back on the first page, clear the draft and exit the wizard
      ref.read(characterDraftProvider.notifier).clearDraft();
      Navigator.of(context).pop();
    }
  }

  Future<void> _nextPage() async {
    if (_currentIndex < _totalPages - 1) {
      // Just navigate to the next page in the wizard
      _pageController.animateToPage(
        _currentIndex + 1,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      // ==========================================
      // THE FORGE INITIATION (Final Step)
      // ==========================================
      debugPrint('--- FORGE INITIATED ---');

      // 1. Fetch the user directly (avoids Stream caching nulls)
      final user = FirebaseAuth.instance.currentUser;

      if (user == null) {
        debugPrint('ERROR: Firebase Auth returned a null user.');
        AppSnackbars.showError('Session lost. Please log out and log back in.');
        return;
      }

      // 2. Read the draft from our Riverpod Clipboard
      final draft = ref.read(characterDraftProvider);

      // 3. Validation Check
      if (draft.name.trim().isEmpty || draft.characterClass.isEmpty) {
        debugPrint('ERROR: User left the Name or Class blank.');
        AppSnackbars.showError(
          'Your hero needs a Name and a Class before forging!',
        );
        return;
      }

      try {
        debugPrint('1. Sending ${draft.name} through the 2024 Math Forge...');
        final newCharacter = CharacterForge.forge(draft, user.uid);

        debugPrint(
          '2. Math complete! Writing to Firestore Document ID: ${newCharacter.id}',
        );
        // 4. Await the database write
        await ref
            .read(characterRepositoryProvider)
            .createCharacter(newCharacter);

        debugPrint('3. Firestore write successful! Clearing clipboard...');
        ref.read(characterDraftProvider.notifier).clearDraft();

        // 5. CRITICAL FLUTTER 3+ CHECK: Ensure the widget is still mounted before using context!
        if (!context.mounted) return;

        debugPrint('4. Exiting Wizard.');

        // Custom Success Snackbar (Since AppSnackbars.showSuccess is pending)
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                '${newCharacter.name} has been forged successfully!',
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              backgroundColor: Colors.green.shade700,
              duration: const Duration(seconds: 3),
              behavior: SnackBarBehavior.floating,
            ),
          );
        }

        // Navigate back to Foyer
        if (mounted) {
          Navigator.of(context).pop();
        }
      } catch (e, stackTrace) {
        debugPrint('--- FORGE CRASHED ---');
        debugPrint('Error: $e');
        debugPrint(stackTrace.toString());

        // We do not need context.mounted here because AppSnackbars.showError doesn't use context!
        AppSnackbars.showError('The forge failed: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.white54),
          onPressed: () {
            ref.read(characterDraftProvider.notifier).clearDraft();
            Navigator.of(context).pop();
          },
        ),
        title: Column(
          children: [
            Text(
              'Step ${_currentIndex + 1} of $_totalPages',
              style: GoogleFonts.inter(
                fontSize: 12,
                color: AppColors.royalPurple,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              _stepTitles[_currentIndex],
              style: GoogleFonts.medievalSharp(
                fontSize: 20,
                color: Colors.white,
              ),
            ),
          ],
        ),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(4.0),
          child: LinearProgressIndicator(
            value: (_currentIndex + 1) / _totalPages,
            backgroundColor: Colors.black.withValues(alpha: 0.3),
            valueColor: const AlwaysStoppedAnimation<Color>(
              AppColors.royalPurple,
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView(
                controller: _pageController,
                physics:
                    const NeverScrollableScrollPhysics(), // Forces users to use the bottom buttons
                onPageChanged: (index) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
                children: const [
                  OriginsStep(),
                  ClassStep(),
                  BackgroundStep(),
                  AbilitiesStep(),
                  EquipmentStep(),
                ],
              ),
            ),

            // --- BOTTOM NAVIGATION BAR ---
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: AppColors.midnightBlue,
                border: Border(
                  top: BorderSide(color: Colors.white.withValues(alpha: 0.05)),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Back Button
                  TextButton(
                    onPressed: _previousPage,
                    child: Text(
                      _currentIndex == 0 ? 'Cancel' : 'Back',
                      style: GoogleFonts.inter(
                        color: Colors.white54,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  // Next / Forge Button
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _currentIndex == _totalPages - 1
                          ? AppColors.legendaryGold
                          : AppColors.royalPurple,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 14,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: _nextPage,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          _currentIndex == _totalPages - 1
                              ? 'Forge Hero'
                              : 'Next Step',
                          style: GoogleFonts.inter(
                            color: _currentIndex == _totalPages - 1
                                ? AppColors.backgroundDark
                                : Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Icon(
                          _currentIndex == _totalPages - 1
                              ? Icons.local_fire_department
                              : Icons.arrow_forward,
                          color: _currentIndex == _totalPages - 1
                              ? AppColors.backgroundDark
                              : Colors.white,
                          size: 18,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
