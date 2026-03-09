import 'package:uuid/uuid.dart';
import '../models/character.dart';
import '../models/character_draft.dart';
import '../data/mock_class_data.dart';
import '../data/mock_species_data.dart';

class CharacterForge {
  /// Transforms a Draft into a final, database-ready Character using 2024 PHB Rules
  static Character forge(CharacterDraft draft, String userId) {
    // 1. Fetch Class & Species Data for derivations
    final classData = advancedClassDatabase[draft.characterClass];
    final speciesData = advancedSpeciesDatabase[draft.race];

    // Fallbacks just in case data is missing
    final hitDiceTotal = classData?.hitDice ?? '1d8';
    final maxHitDieValue = int.tryParse(hitDiceTotal.split('d').last) ?? 8;

    // Parse speed (e.g., "30 ft." -> 30)
    final speedString =
        speciesData?.speed.replaceAll(RegExp(r'[^0-9]'), '') ?? '30';
    final baseSpeed = int.tryParse(speedString) ?? 30;

    // 2. Calculate Math (Constitution & Dexterity Modifiers)
    final conTotal = draft.baseCon + draft.bonusCon;
    final dexTotal = draft.baseDex + draft.bonusDex;
    final conMod = ((conTotal - 10) / 2).floor();
    final dexMod = ((dexTotal - 10) / 2).floor();

    // 3. Apply 2024 Rules Engine
    final int level1Hp = maxHitDieValue + conMod;
    final int baseAc = 10 + dexMod; // Base Unarmored AC
    final int initiative = dexMod; // Base Initiative is strictly Dex Mod

    // 4. Handle Custom Background injection
    final finalBackground = draft.background == 'Custom'
        ? draft.customBackgroundName
        : draft.background;

    final finalBackstory =
        draft.background == 'Custom' && draft.backstory.isEmpty
        ? draft.customBackgroundDescription
        : draft.backstory;

    // 5. Generate a unique ID for the new character
    final newId = const Uuid().v4();

    return Character(
      id: newId,
      ownerId: userId,

      // Identity
      name: draft.name,
      race: draft.race,
      subrace: draft.subrace ?? '',
      gender: draft.gender,
      characterClass: draft.characterClass,
      level: draft.level,
      background: finalBackground,
      alignment: draft.alignment,

      // Physical & Personality
      age: draft.age,
      height: draft.height,
      weight: draft.weight,
      eyes: draft.eyes,
      skin: draft.skin,
      hair: draft.hair,
      personalityTraits: draft.personalityTraits,
      ideals: draft.ideals,
      bonds: draft.bonds,
      flaws: draft.flaws,
      backstory: finalBackstory,

      // Core Stats
      generationMethod: draft.generationMethod,
      baseScores: {
        'STR': draft.baseStr,
        'DEX': draft.baseDex,
        'CON': draft.baseCon,
        'INT': draft.baseInt,
        'WIS': draft.baseWis,
        'CHA': draft.baseCha,
      },
      bonusScores: {
        'STR': draft.bonusStr,
        'DEX': draft.bonusDex,
        'CON': draft.bonusCon,
        'INT': draft.bonusInt,
        'WIS': draft.bonusWis,
        'CHA': draft.bonusCha,
      },

      // Calculated 2024 Vitals
      hpMax: level1Hp,
      hpCurrent: level1Hp,
      hitDiceTotal: hitDiceTotal,
      hitDiceCurrent: draft.level,
      armorClassBase: baseAc,
      speedBase: baseSpeed,
      initiativeBonus: initiative,

      // Equipment
      inventory: draft.inventory,
      currency: {
        'cp': draft.cp,
        'sp': draft.sp,
        'ep': draft.ep,
        'gp': draft.gp,
        'pp': draft.pp,
      },
    );
  }
}
