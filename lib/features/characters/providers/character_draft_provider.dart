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

  void updateBaseStat({required String stat, required int value}) {
    switch (stat) {
      case 'str':
        state = state.copyWith(baseStr: value);
        break;
      case 'dex':
        state = state.copyWith(baseDex: value);
        break;
      case 'con':
        state = state.copyWith(baseCon: value);
        break;
      case 'int':
        state = state.copyWith(baseInt: value);
        break;
      case 'wis':
        state = state.copyWith(baseWis: value);
        break;
      case 'cha':
        state = state.copyWith(baseCha: value);
        break;
    }
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
