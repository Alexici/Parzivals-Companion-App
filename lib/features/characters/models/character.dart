class Character {
  final String id;
  final String ownerId;

  // 1. Identity & Origins
  final String name;
  final String race;
  final String subrace;
  final String gender;
  final String characterClass;
  final int level;
  final String background;
  final String alignment;
  final int experiencePoints;

  // 2. Physical & Personality
  final String age, height, weight, eyes, skin, hair;
  final String personalityTraits, ideals, bonds, flaws, backstory;

  // 3. Core Stats (Stored as Maps for NoSQL efficiency)
  final String generationMethod;
  final Map<String, int> baseScores;
  final Map<String, int> bonusScores;

  // 4. Vitals & Combat (The Calculated Engine)
  final int hpMax;
  final int hpCurrent;
  final int hpTemp;
  final String hitDiceTotal;
  final int hitDiceCurrent;
  final int armorClassBase;
  final int speedBase;
  final int initiativeBonus;

  // 5. Inventory & Economy
  final List<String> inventory;
  final Map<String, int> currency;

  Character({
    required this.id,
    required this.ownerId,
    required this.name,
    required this.race,
    required this.subrace,
    required this.gender,
    required this.characterClass,
    required this.level,
    required this.background,
    required this.alignment,
    this.experiencePoints = 0,
    required this.age,
    required this.height,
    required this.weight,
    required this.eyes,
    required this.skin,
    required this.hair,
    required this.personalityTraits,
    required this.ideals,
    required this.bonds,
    required this.flaws,
    required this.backstory,
    required this.generationMethod,
    required this.baseScores,
    required this.bonusScores,
    required this.hpMax,
    required this.hpCurrent,
    this.hpTemp = 0,
    required this.hitDiceTotal,
    required this.hitDiceCurrent,
    required this.armorClassBase,
    required this.speedBase,
    required this.initiativeBonus,
    required this.inventory,
    required this.currency,
  });

  // Convert TO Firestore JSON
  Map<String, dynamic> toMap() {
    return {
      'ownerId': ownerId,
      'name': name,
      'race': race,
      'subrace': subrace,
      'gender': gender,
      'characterClass': characterClass,
      'level': level,
      'background': background,
      'alignment': alignment,
      'experiencePoints': experiencePoints,
      'age': age,
      'height': height,
      'weight': weight,
      'eyes': eyes,
      'skin': skin,
      'hair': hair,
      'personalityTraits': personalityTraits,
      'ideals': ideals,
      'bonds': bonds,
      'flaws': flaws,
      'backstory': backstory,
      'generationMethod': generationMethod,
      'baseScores': baseScores,
      'bonusScores': bonusScores,
      'hpMax': hpMax,
      'hpCurrent': hpCurrent,
      'hpTemp': hpTemp,
      'hitDiceTotal': hitDiceTotal,
      'hitDiceCurrent': hitDiceCurrent,
      'armorClassBase': armorClassBase,
      'speedBase': speedBase,
      'initiativeBonus': initiativeBonus,
      'inventory': inventory,
      'currency': currency,
    };
  }

  // Convert FROM Firestore JSON
  factory Character.fromMap(Map<String, dynamic> map, String documentId) {
    return Character(
      id: documentId,
      ownerId: map['ownerId'] ?? '',
      name: map['name'] ?? '',
      race: map['race'] ?? '',
      subrace: map['subrace'] ?? '',
      gender: map['gender'] ?? '',
      characterClass: map['characterClass'] ?? '',
      level: map['level'] ?? 1,
      background: map['background'] ?? '',
      alignment: map['alignment'] ?? '',
      experiencePoints: map['experiencePoints'] ?? 0,
      age: map['age'] ?? '',
      height: map['height'] ?? '',
      weight: map['weight'] ?? '',
      eyes: map['eyes'] ?? '',
      skin: map['skin'] ?? '',
      hair: map['hair'] ?? '',
      personalityTraits: map['personalityTraits'] ?? '',
      ideals: map['ideals'] ?? '',
      bonds: map['bonds'] ?? '',
      flaws: map['flaws'] ?? '',
      backstory: map['backstory'] ?? '',
      generationMethod: map['generationMethod'] ?? '',
      baseScores: Map<String, int>.from(map['baseScores'] ?? {}),
      bonusScores: Map<String, int>.from(map['bonusScores'] ?? {}),
      hpMax: map['hpMax'] ?? 0,
      hpCurrent: map['hpCurrent'] ?? 0,
      hpTemp: map['hpTemp'] ?? 0,
      hitDiceTotal: map['hitDiceTotal'] ?? '',
      hitDiceCurrent: map['hitDiceCurrent'] ?? 0,
      armorClassBase: map['armorClassBase'] ?? 10,
      speedBase: map['speedBase'] ?? 30,
      initiativeBonus: map['initiativeBonus'] ?? 0,
      inventory: List<String>.from(map['inventory'] ?? []),
      currency: Map<String, int>.from(map['currency'] ?? {}),
    );
  }
}
