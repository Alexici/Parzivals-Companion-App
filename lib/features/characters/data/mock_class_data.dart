import '../models/character_class.dart';

final Map<String, CharacterClass> advancedClassDatabase = {
  'Barbarian': const CharacterClass(
    name: 'Barbarian',
    description: 'A fierce warrior who enters a battle rage.',
    hitDice: '1d12',
    primaryAbility: 'Strength',
    saves: 'Strength, Constitution',
    level1Features: [
      ClassFeature(
        name: 'Rage',
        description:
            'You can enter a Rage as a Bonus Action. While Raging, you gain Advantage on Strength checks/saves, bonus damage to Strength-based melee attacks, and Resistance to Bludgeoning, Piercing, and Slashing damage.',
      ),
      ClassFeature(
        name: 'Unarmored Defense',
        description:
            'While you aren\'t wearing armor, your base Armor Class equals 10 + your Dexterity modifier + your Constitution modifier. You can use a Shield and still gain this benefit.',
      ),
      ClassFeature(
        name: 'Weapon Mastery',
        description:
            'Your training with weapons allows you to use the Mastery properties of two kinds of Simple or Martial melee weapons of your choice.',
      ),
    ],
  ),
  'Bard': const CharacterClass(
    name: 'Bard',
    description:
        'An inspiring magician whose power echoes the music of creation.',
    hitDice: '1d8',
    primaryAbility: 'Charisma',
    saves: 'Dexterity, Charisma',
    level1Features: [
      ClassFeature(
        name: 'Spellcasting',
        description:
            'You have learned to untangle and reshape the fabric of reality in harmony with your wishes and music. You know two cantrips and four level 1 spells from the Bard spell list.',
      ),
      ClassFeature(
        name: 'Bardic Inspiration',
        description:
            'You can supernaturally inspire others through words, music, or dance. As a Bonus Action, give a creature a Bardic Inspiration die (a d6) to add to a d20 Test.',
      ),
    ],
  ),
  'Cleric': const CharacterClass(
    name: 'Cleric',
    description:
        'A priestly champion who wields divine magic in service of a higher power.',
    hitDice: '1d8',
    primaryAbility: 'Wisdom',
    saves: 'Wisdom, Charisma',
    level1Features: [
      ClassFeature(
        name: 'Spellcasting',
        description:
            'You can cast Cleric spells. You know three cantrips and always have a specific number of level 1 spells prepared from the Cleric spell list.',
      ),
      ClassFeature(
        name: 'Divine Order',
        description:
            'You have dedicated yourself to one of the following sacred roles: Protector (gain Martial Weapon and Heavy Armor proficiency) or Thaumaturge (gain an extra cantrip and a bonus to Religion/Arcana checks).',
      ),
    ],
  ),
  'Fighter': const CharacterClass(
    name: 'Fighter',
    description:
        'A master of martial combat, skilled with a variety of weapons and armor.',
    hitDice: '1d10',
    primaryAbility: 'Strength or Dexterity',
    saves: 'Strength, Constitution',
    level1Features: [
      ClassFeature(
        name: 'Fighting Style',
        description:
            'You gain a Fighting Style feat of your choice, such as Archery, Defense, or Great Weapon Fighting.',
      ),
      ClassFeature(
        name: 'Second Wind',
        description:
            'You have a limited well of stamina that you can draw on to protect yourself from harm. As a Bonus Action, you regain Hit Points equal to 1d10 + your Fighter level.',
      ),
      ClassFeature(
        name: 'Weapon Mastery',
        description:
            'Your training with weapons allows you to use the Mastery properties of three kinds of Simple or Martial weapons of your choice.',
      ),
    ],
  ),
  'Rogue': const CharacterClass(
    name: 'Rogue',
    description:
        'A scoundrel who uses stealth and trickery to overcome obstacles and enemies.',
    hitDice: '1d8',
    primaryAbility: 'Dexterity',
    saves: 'Dexterity, Intelligence',
    level1Features: [
      ClassFeature(
        name: 'Expertise',
        description:
            'Choose two of your skill proficiencies. Your Proficiency Bonus is doubled for any ability check you make that uses either of the chosen proficiencies.',
      ),
      ClassFeature(
        name: 'Sneak Attack',
        description:
            'You know how to strike subtly and exploit a foe\'s distraction. Once per turn, you can deal an extra 1d6 damage to one creature you hit with an attack if you have Advantage on the attack roll.',
      ),
      ClassFeature(
        name: 'Weapon Mastery',
        description:
            'Your training with weapons allows you to use the Mastery properties of two kinds of Simple or Martial weapons of your choice.',
      ),
      ClassFeature(
        name: 'Thieves\' Cant',
        description:
            'You picked up a mix of dialect, jargon, and secret codes that allows you to hide messages in seemingly normal conversation.',
      ),
    ],
  ),
  'Wizard': const CharacterClass(
    name: 'Wizard',
    description:
        'A scholarly magic-user capable of manipulating the structures of reality.',
    hitDice: '1d6',
    primaryAbility: 'Intelligence',
    saves: 'Intelligence, Wisdom',
    level1Features: [
      ClassFeature(
        name: 'Spellcasting',
        description:
            'As a student of arcane magic, you have a spellbook containing spells that show the first glimmerings of your true power. You know three cantrips and possess a spellbook with six level 1 Wizard spells.',
      ),
      ClassFeature(
        name: 'Arcane Recovery',
        description:
            'You have learned to regain some of your magical energy by studying your spellbook. Once per day during a Short Rest, you can choose expended spell slots to recover.',
      ),
      ClassFeature(
        name: 'Ritual Casting',
        description:
            'You can cast a Wizard spell as a Ritual if that spell has the Ritual tag and you have the spell in your spellbook. You don\'t need to have the spell prepared.',
      ),
    ],
  ),
  // (You can add Druid, Monk, Paladin, Ranger, Sorcerer, Warlock using the same format!)
};
