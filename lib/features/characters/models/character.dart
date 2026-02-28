class Character {
  final String id; // Unique identifier for the character
  final String ownerId; // User ID of the character's owner
  final String? campaignId; // ID of the campaign the character belongs to

  final String name;
  final String race;
  final String characterClass;
  final int level;

  final int currentHP;
  final int maxHP;
  final int armorClass;

  Character({
    required this.id,
    required this.ownerId,
    this.campaignId,
    required this.name,
    required this.race,
    required this.characterClass,
    required this.level,
    required this.currentHP,
    required this.maxHP,
    required this.armorClass,
  });

  // Factory constructor to create a Character instance from a Firestore document
  factory Character.fromMap(Map<String, dynamic> map, String documentId) {
    return Character(
      id: documentId,
      ownerId: map['ownerId'] ?? '',
      campaignId: map['campaignId'],
      name: map['name'] ?? 'Unknown Adventurer',
      race: map['race'] ?? 'Human',
      characterClass: map['characterClass'] ?? 'Fighter',
      level: map['level']?.toInt() ?? 1,
      currentHP: map['currentHP']?.toInt() ?? 10,
      maxHP: map['maxHP']?.toInt() ?? 10,
      armorClass: map['armorClass']?.toInt() ?? 10,
    );
  }

  // Method to convert a Character instance to a map for Firestore storage
  Map<String, dynamic> toMap() {
    return {
      'ownerId': ownerId,
      'campaignId': campaignId,
      'name': name,
      'race': race,
      'characterClass': characterClass,
      'level': level,
      'currentHP': currentHP,
      'maxHP': maxHP,
      'armorClass': armorClass,
    };
  }

  // Method to create a copy of the character with updated fields
  Character copyWith({
    String? id,
    String? ownerId,
    String? campaignId,
    String? name,
    String? race,
    String? characterClass,
    int? level,
    int? currentHP,
    int? maxHP,
    int? armorClass,
  }) {
    return Character(
      id: id ?? this.id,
      ownerId: ownerId ?? this.ownerId,
      campaignId: campaignId ?? this.campaignId,
      name: name ?? this.name,
      race: race ?? this.race,
      characterClass: characterClass ?? this.characterClass,
      level: level ?? this.level,
      currentHP: currentHP ?? this.currentHP,
      maxHP: maxHP ?? this.maxHP,
      armorClass: armorClass ?? this.armorClass,
    );
  }
}
