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

  // --- Step E: Equipment ---
  final List<String> startingEquipment;
  final int startingGold;

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
    this.startingEquipment = const [],
    this.startingGold = 0,
    this.customBackgroundName = '',
    this.customBackgroundDescription = '',
  });

  // The secret sauce: This lets us copy the current draft and change just ONE piece of data
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
    List<String>? startingEquipment,
    int? startingGold,
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
      startingEquipment: startingEquipment ?? this.startingEquipment,
      startingGold: startingGold ?? this.startingGold,
      customBackgroundName: customBackgroundName ?? this.customBackgroundName,
      customBackgroundDescription:
          customBackgroundDescription ?? this.customBackgroundDescription,
    );
  }
}
