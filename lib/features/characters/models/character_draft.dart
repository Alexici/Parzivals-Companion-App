class CharacterDraft {
  // --- Step A: Origins ---
  final String name;
  final String race;
  final String? subrace;
  final String gender;

  // --- Step B: Class ---
  final String characterClass;
  final int level;

  // --- Step C: Background ---
  final String background;
  final String alignment;
  final String age;
  final String height;
  final String weight;
  final String eyes;
  final String skin;
  final String hair;
  final String personalityTraits;
  final String ideals;
  final String bonds;
  final String flaws;
  final String backstory;
  final String customBackgroundName;
  final String customBackgroundDescription;

  // --- Step D: Abilities (Base Scores) ---
  final String generationMethod;
  final int baseStr, baseDex, baseCon, baseInt, baseWis, baseCha;
  final int bonusStr, bonusDex, bonusCon, bonusInt, bonusWis, bonusCha;

  // --- Step E: Equipment ---
  final String equipmentChoice;
  final List<String> inventory;
  final int cp, sp, ep, gp, pp;

  const CharacterDraft({
    this.name = '',
    this.race = '',
    this.subrace,
    this.gender = '',
    this.characterClass = '',
    this.level = 1,
    this.background = '',
    this.alignment = '',
    this.age = '',
    this.height = '',
    this.weight = '',
    this.eyes = '',
    this.skin = '',
    this.hair = '',
    this.personalityTraits = '',
    this.ideals = '',
    this.bonds = '',
    this.flaws = '',
    this.backstory = '',
    this.generationMethod = 'standardArray',
    this.baseStr = 8,
    this.baseDex = 8,
    this.baseCon = 8,
    this.baseInt = 8,
    this.baseWis = 8,
    this.baseCha = 8,
    this.bonusStr = 0,
    this.bonusDex = 0,
    this.bonusCon = 0,
    this.bonusInt = 0,
    this.bonusWis = 0,
    this.bonusCha = 0,
    this.equipmentChoice = '',
    this.inventory = const [],
    this.cp = 0,
    this.sp = 0,
    this.ep = 0,
    this.gp = 0,
    this.pp = 0,
    this.customBackgroundName = '',
    this.customBackgroundDescription = '',
  });

  // The copyWith method
  CharacterDraft copyWith({
    String? name,
    String? race,
    String? subrace,
    String? gender,
    String? characterClass,
    int? level,
    String? background,
    String? alignment,
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
    String? generationMethod,
    int? baseStr,
    int? baseDex,
    int? baseCon,
    int? baseInt,
    int? baseWis,
    int? baseCha,
    int? bonusStr,
    int? bonusDex,
    int? bonusCon,
    int? bonusInt,
    int? bonusWis,
    int? bonusCha,
    String? equipmentChoice,
    List<String>? inventory,
    int? cp,
    int? sp,
    int? ep,
    int? gp,
    int? pp,
    String? customBackgroundName,
    String? customBackgroundDescription,
  }) {
    return CharacterDraft(
      name: name ?? this.name,
      race: race ?? this.race,
      subrace: subrace ?? this.subrace,
      gender: gender ?? this.gender,
      characterClass: characterClass ?? this.characterClass,
      level: level ?? this.level,
      background: background ?? this.background,
      alignment: alignment ?? this.alignment,
      age: age ?? this.age,
      height: height ?? this.height,
      weight: weight ?? this.weight,
      eyes: eyes ?? this.eyes,
      skin: skin ?? this.skin,
      hair: hair ?? this.hair,
      personalityTraits: personalityTraits ?? this.personalityTraits,
      ideals: ideals ?? this.ideals,
      bonds: bonds ?? this.bonds,
      flaws: flaws ?? this.flaws,
      backstory: backstory ?? this.backstory,
      generationMethod: generationMethod ?? this.generationMethod,
      baseStr: baseStr ?? this.baseStr,
      baseDex: baseDex ?? this.baseDex,
      baseCon: baseCon ?? this.baseCon,
      baseInt: baseInt ?? this.baseInt,
      baseWis: baseWis ?? this.baseWis,
      baseCha: baseCha ?? this.baseCha,
      bonusStr: bonusStr ?? this.bonusStr,
      bonusDex: bonusDex ?? this.bonusDex,
      bonusCon: bonusCon ?? this.bonusCon,
      bonusInt: bonusInt ?? this.bonusInt,
      bonusWis: bonusWis ?? this.bonusWis,
      bonusCha: bonusCha ?? this.bonusCha,
      equipmentChoice: equipmentChoice ?? this.equipmentChoice,
      inventory: inventory ?? this.inventory,
      cp: cp ?? this.cp,
      sp: sp ?? this.sp,
      ep: ep ?? this.ep,
      gp: gp ?? this.gp,
      pp: pp ?? this.pp,
      customBackgroundName: customBackgroundName ?? this.customBackgroundName,
      customBackgroundDescription:
          customBackgroundDescription ?? this.customBackgroundDescription,
    );
  }
}
