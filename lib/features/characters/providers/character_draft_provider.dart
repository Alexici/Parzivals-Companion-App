import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/character_draft.dart';

class CharacterDraftNotifier extends Notifier<CharacterDraft> {
  // Initializes the state with a default CharacterDraft instance.
  @override
  CharacterDraft build() {
    return const CharacterDraft();
  }

  // Update Origins
  void updateOrigins({
    String? name,
    String? race,
    String? subrace,
    String? gender,
  }) {
    state = state.copyWith(
      name: name,
      race: race,
      subrace: subrace,
      gender: gender,
    );
  }

  // Update Class
  void updateClass({String? characterClass, int? level}) {
    state = state.copyWith(characterClass: characterClass, level: level);
  }

  // Name update
  void updateName(String newName) {
    state = state.copyWith(name: newName);
  }

  // Step C: Update Background & Details
  void updateBackgroundDetails({
    String? background,
    String? customBackgroundName,
    String? customBackgroundDescription,
    String? alignment,
    String? gender,
    String? age,
    String? height,
    String? weight,
    String? eyes,
    String? skin,
    String? hair,
    String? personalityTraits,
    String? ideals,
    String? bonds,
    String? flaws,
    String? backstory,
  }) {
    state = state.copyWith(
      background: background,
      customBackgroundName: customBackgroundName,
      customBackgroundDescription: customBackgroundDescription,
      alignment: alignment,
      gender: gender,
      age: age,
      height: height,
      weight: weight,
      eyes: eyes,
      skin: skin,
      hair: hair,
      personalityTraits: personalityTraits,
      ideals: ideals,
      bonds: bonds,
      flaws: flaws,
      backstory: backstory,
    );
  }

  // Step D: Update Abilities
  void updateGenerationMethod(String method) {
    int defaultVal = method == 'Point Buy' ? 8 : 0;
    state = state.copyWith(
      generationMethod: method,
      baseStr: defaultVal,
      baseDex: defaultVal,
      baseCon: defaultVal,
      baseInt: defaultVal,
      baseWis: defaultVal,
      baseCha: defaultVal,
    );
  }

  void updateBaseStat({required String stat, required int value}) {
    switch (stat) {
      case 'STR':
        state = state.copyWith(baseStr: value);
        break;
      case 'DEX':
        state = state.copyWith(baseDex: value);
        break;
      case 'CON':
        state = state.copyWith(baseCon: value);
        break;
      case 'INT':
        state = state.copyWith(baseInt: value);
        break;
      case 'WIS':
        state = state.copyWith(baseWis: value);
        break;
      case 'CHA':
        state = state.copyWith(baseCha: value);
        break;
    }
  }

  // Clear bonuses
  void clearBonuses() {
    state = state.copyWith(
      bonusStr: 0,
      bonusDex: 0,
      bonusCon: 0,
      bonusInt: 0,
      bonusWis: 0,
      bonusCha: 0,
    );
  }

  // Update bonuses
  void updateBonusStat({required String stat, required int value}) {
    switch (stat) {
      case 'STR':
        state = state.copyWith(bonusStr: value);
        break;
      case 'DEX':
        state = state.copyWith(bonusDex: value);
        break;
      case 'CON':
        state = state.copyWith(bonusCon: value);
        break;
      case 'INT':
        state = state.copyWith(bonusInt: value);
        break;
      case 'WIS':
        state = state.copyWith(bonusWis: value);
        break;
      case 'CHA':
        state = state.copyWith(bonusCha: value);
        break;
    }
  }

  // Step E: Equipment
  void setEquipmentChoice({
    required String newChoice,
    required List<String> packageItems,
    required int startingGold,
  }) {
    // 1. If they click the option they already have selected, do nothing!
    if (state.equipmentChoice == newChoice) return;

    List<String> updatedInventory = List.from(state.inventory);

    // 2. If they are switching AWAY from 'Package', remove the package items
    if (state.equipmentChoice == 'Package') {
      for (var item in packageItems) {
        updatedInventory.remove(item);
      }
    }

    // 3. If they are switching TO 'Package', add the package items
    if (newChoice == 'Package') {
      updatedInventory.addAll(packageItems);
    }

    // 4. Save the state
    state = state.copyWith(
      equipmentChoice: newChoice,
      inventory: updatedInventory,
      gp: startingGold,
    );
  }

  void addCustomItem(String item) {
    if (item.trim().isEmpty) return;
    state = state.copyWith(inventory: [...state.inventory, item.trim()]);
  }

  void removeInventoryItem(int index) {
    final newList = List<String>.from(state.inventory);
    newList.removeAt(index);
    state = state.copyWith(inventory: newList);
  }

  void updateCurrency({int? cp, int? sp, int? ep, int? gp, int? pp}) {
    state = state.copyWith(
      cp: cp ?? state.cp,
      sp: sp ?? state.sp,
      ep: ep ?? state.ep,
      gp: gp ?? state.gp,
      pp: pp ?? state.pp,
    );
  }

  // Function called when the user hits cancel or when they successfully create the character
  // The function clears the draft and resets it to the default state.
  void clearDraft() {
    state = const CharacterDraft();
  }
}

// Provider for the CharacterDraftNotifier, allowing it to be accessed throughout the app.
final characterDraftProvider =
    NotifierProvider<CharacterDraftNotifier, CharacterDraft>(
      () => CharacterDraftNotifier(),
    );
