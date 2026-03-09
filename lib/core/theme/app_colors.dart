import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // ==========================================
  // CORE BACKGROUNDS & VOIDS
  // ==========================================
  // Thematic dark backgrounds that set the tone for the app.

  // Standart material black
  static const Color backgroundDark = Color(0xFF121212);
  // Deep shadow and elevation
  static const Color abyssalBlack = Color(0xFF000401);
  // Pure Black
  static const Color pitchBlack = Color(0xFF000000);

  // ==========================================
  // SURFACES & ELEVATIONS
  // ==========================================
  // Used for cards, modals, and glass containers

  // Thematic background for AppBars or magical modals
  static const Color midnightBlue = Color(0xFF081849);
  // Solid base for elevated surfaces and tooltips
  static const Color charcoal = Color(0xFF36454F);
  // Thematic surface for Ranger/Druid specific UI, like nature-themed cards or backgrounds
  static const Color deepForest = Color(0xFF182D09);

  // ==========================================
  // BRAND & MAGICAL ACCENTS
  // ==========================================
  // High-saturation colors used sparingly to draw the user's eye

  // Primary Brand: Primary buttons, active borders
  static const Color royalPurple = Color(0xFF4B006E);
  // Glow effects, hover states, spell slots
  static const Color accentPurple = Colors.deepPurpleAccent;
  // Gold accent for important highlights
  static const Color legendaryGold = Color(0xFFFFD700);
  // Arcane Blue accent for magic related UI elements, like spell lists or wizard steps
  static const Color arcaneBlue = Color(0xFF00D4FF);

  // ==========================================
  // SEMANTIC & COMBAT STATUS
  // ==========================================
  // Crucial for UX. These immediately communicate state to the player.

  // Success, saving throws passed, HP restored
  static const Color healingGreen = Color(0xFF2E8B57);
  // Danger, taking damage, failed saves
  static const Color bloodRed = Color(0xFF8B0000);
  // Warnings, conditions applied (e.g., poisoned, stunned)
  static const Color firebrandOrange = Color(0xFFFF4500);

  // ==========================================
  // TEXT & NEUTRALS
  // ==========================================
  // Ensuring WCAG-compliant contrast ratios for readability.

  // Primary text, active icons
  static const Color glassWhite = Colors.white;
  // Bone white for secondary text, thematic flavor
  static const Color boneWhite = Color(0xFFE2DAC8);
  // Grey for disabled text, inactive icons, and dividers
  static const Color steelGrey = Color(0xFF7A7A7A);
  // Slate Grey for subtle UI elements
  static const Color slateGrey = Color(0xFF708090);
}
