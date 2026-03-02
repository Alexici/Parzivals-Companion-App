import 'dart:ui';

import 'package:dnd_companion/core/theme/app_colors.dart%20';
import 'package:dnd_companion/features/characters/screens/steps/background_step.dart';
import 'package:dnd_companion/features/characters/screens/steps/class_step.dart';
import 'package:dnd_companion/features/characters/screens/steps/origins_step.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CharacterCreationScreen extends StatefulWidget {
  const CharacterCreationScreen({super.key});

  @override
  State<CharacterCreationScreen> createState() =>
      _CharacterCreationScreenState();
}

class _CharacterCreationScreenState extends State<CharacterCreationScreen> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;
  final int _totalPages = 5;

  // Titles
  final List<String> _stepTitles = [
    'The Origins',
    'The Class',
    'The Background',
    'The Abilities',
    'The Equipment',
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  // Next Page function
  void _nextPage() {
    if (_currentIndex < _totalPages - 1) {
      _pageController.animateToPage(
        _currentIndex + 1,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      // TODO: Finalize character creation (a confirmation pop-up and then save to database)
    }
  }

  // Previous Page function
  void _previousPage() {
    if (_currentIndex > 0) {
      _pageController.animateToPage(
        _currentIndex - 1,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          child: Column(
            children: [
              // Header
              Padding(
                padding: const EdgeInsetsGeometry.symmetric(
                  horizontal: 8.0,
                  vertical: 16.0,
                ),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () async {
                        final shouldLeave = await showDialog<bool>(
                          context: context,
                          barrierColor: Colors.transparent,
                          builder: (dialogContext) {
                            return BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
                              child: Dialog(
                                backgroundColor: Colors.black.withValues(
                                  alpha: 0.55,
                                ),
                                insetPadding: const EdgeInsets.symmetric(
                                  horizontal: 24,
                                  vertical: 24,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(20),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      Text(
                                        'Leave creation?',
                                        style: GoogleFonts.medievalSharp(
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                      const SizedBox(height: 12),
                                      const Text(
                                        'Your current progress will be lost.',
                                        style: TextStyle(color: Colors.white70),
                                        textAlign: TextAlign.center,
                                      ),
                                      const SizedBox(height: 20),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: OutlinedButton(
                                              onPressed: () => Navigator.of(
                                                dialogContext,
                                              ).pop(false),
                                              style: OutlinedButton.styleFrom(
                                                foregroundColor: Colors.white,
                                                side: const BorderSide(
                                                  color: Colors.white54,
                                                ),
                                              ),
                                              child: const Text('Stay'),
                                            ),
                                          ),
                                          const SizedBox(width: 12),
                                          Expanded(
                                            child: ElevatedButton(
                                              onPressed: () => Navigator.of(
                                                dialogContext,
                                              ).pop(true),
                                              child: const Text('Leave'),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                        if (shouldLeave == true && context.mounted) {
                          Navigator.of(context).pop();
                        }
                      },
                      icon: const Icon(Icons.arrow_back, color: Colors.white),
                    ),
                    Expanded(
                      child: Text(
                        _stepTitles[_currentIndex],
                        textAlign: TextAlign.center,
                        style: GoogleFonts.medievalSharp(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(width: 48), // Placeholder for symmetry
                  ],
                ),
              ),

              // PageView for steps
              Expanded(
                child: PageView(
                  controller: _pageController,
                  physics: const NeverScrollableScrollPhysics(),
                  onPageChanged: (index) {
                    setState(() => _currentIndex = index);
                  },
                  children: [
                    const OriginsStep(),
                    const ClassStep(),
                    const BackgroundStep(),
                    _buildPlaceholder(
                      'Ability score generation (standard array or manual)',
                    ),
                    _buildPlaceholder('Starting equipment selection'),
                  ],
                ),
              ),
              // Navigation Buttons
              Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    DotsIndicator(
                      dotsCount: _totalPages,
                      position: _currentIndex.toDouble(),
                      decorator: DotsDecorator(
                        activeColor: AppColors.royalPurple,
                        color: Colors.white10,
                        size: const Size.square(9.0),
                        activeSize: const Size(24.0, 9.0),
                        activeShape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          onPressed: _currentIndex > 0 ? _previousPage : null,
                          style: TextButton.styleFrom(
                            foregroundColor: _currentIndex > 0
                                ? Colors.white70
                                : Colors.grey,
                          ),
                          child: const Text('Previous'),
                        ),
                        ElevatedButton(
                          onPressed: _nextPage,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.royalPurple,
                            foregroundColor: Colors.white,
                          ),
                          child: Text(
                            _currentIndex == _totalPages - 1
                                ? 'Forge Hero'
                                : 'Next',
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPlaceholder(String text) {
    return Center(
      child: Text(
        text,
        style: GoogleFonts.inter(fontSize: 18, color: Colors.white54),
        textAlign: TextAlign.center,
      ),
    );
  }
}
