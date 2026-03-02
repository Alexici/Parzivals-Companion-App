// lib/features/characters/data/mock_species_data.dart
import '../models/species.dart';

const Map<String, Species> advancedSpeciesDatabase = {
  'Dragonborn': Species(
    name: 'Dragonborn',
    description:
        'Dragonborn look very much like dragons standing erect in humanoid form, though they lack wings or a tail.',
    size: 'Medium',
    speed: '30 ft.',
    lineageLabel: 'Draconic Ancestry',
    traits: [
      Trait(
        name: 'Darkvision',
        description: 'You can see in dim light and darkness up to 60 feet.',
      ),
      Trait(
        name: 'Breath Weapon',
        description:
            'When you take the Attack action, you can replace one of your attacks with an exhalation of magical energy in a 15-foot cone or 30-foot line.',
      ),
      Trait(
        name: 'Draconic Flight',
        description:
            'At level 5, as a Bonus Action, you can sprout spectral wings and gain a Fly Speed equal to your Speed for 10 minutes.',
      ),
    ],
    lineages: {
      'Black':
          'Your Breath Weapon and Damage Resistance are tied to Acid damage.',
      'Blue':
          'Your Breath Weapon and Damage Resistance are tied to Lightning damage.',
      'Brass':
          'Your Breath Weapon and Damage Resistance are tied to Fire damage.',
      'Bronze':
          'Your Breath Weapon and Damage Resistance are tied to Lightning damage.',
      'Copper':
          'Your Breath Weapon and Damage Resistance are tied to Acid damage.',
      'Gold':
          'Your Breath Weapon and Damage Resistance are tied to Fire damage.',
      'Green':
          'Your Breath Weapon and Damage Resistance are tied to Poison damage.',
      'Red':
          'Your Breath Weapon and Damage Resistance are tied to Fire damage.',
      'Silver':
          'Your Breath Weapon and Damage Resistance are tied to Cold damage.',
      'White':
          'Your Breath Weapon and Damage Resistance are tied to Cold damage.',
    },
  ),
  'Dwarf': Species(
    name: 'Dwarf',
    description:
        'Bold and hardy, dwarves are known as skilled warriors, miners, and workers of stone and metal.',
    size: 'Medium',
    speed: '30 ft.',
    traits: [
      Trait(
        name: 'Darkvision',
        description:
            'You have superior vision in dark and dim conditions, up to 120 feet.',
      ),
      Trait(
        name: 'Dwarven Resilience',
        description:
            'You have Resistance to Poison damage and Advantage on saving throws against the Poisoned condition.',
      ),
      Trait(
        name: 'Dwarven Toughness',
        description:
            'Your Hit Point maximum increases by 1, and it increases by 1 every time you gain a level.',
      ),
      Trait(
        name: 'Stonecunning',
        description:
            'As a Bonus Action, you gain Tremorsense with a range of 60 feet for 10 minutes. You must be on a stone surface or touching one.',
      ),
    ],
    lineages: {},
  ),
  'Elf': Species(
    name: 'Elf',
    description:
        'Elves are a magical people of otherworldly grace, living in the world but not entirely part of it.',
    size: 'Medium',
    speed: '30 ft.',
    traits: [
      Trait(
        name: 'Darkvision',
        description: 'You can see in dim light and darkness up to 60 feet.',
      ),
      Trait(
        name: 'Fey Ancestry',
        description:
            'You have Advantage on saving throws to prevent or end the Charmed condition on yourself.',
      ),
      Trait(
        name: 'Keen Senses',
        description:
            'You have proficiency in the Insight, Perception, or Survival skill.',
      ),
      Trait(
        name: 'Trance',
        description:
            'You don’t need to sleep, and magic can’t put you to sleep. You can finish a Long Rest in 4 hours if you spend those hours in a trancelike meditation.',
      ),
    ],
    lineages: {
      'Drow':
          'Your Darkvision range increases to 120 ft. You know the Dancing Lights cantrip. At higher levels, you learn Faerie Fire and Darkness.',
      'High Elf':
          'You know the Prestidigitation cantrip and can swap it for another Wizard cantrip after a Long Rest. At higher levels, you learn Detect Magic and Misty Step.',
      'Wood Elf':
          'Your Speed increases to 35 ft. You know the Druidcraft cantrip. At higher levels, you learn Longstrider and Pass Without Trace.',
    },
  ),
  'Gnome': Species(
    name: 'Gnome',
    description:
        'Gnomes are small, secretive, and clever humanoids known for their vibrant curiosity and magical aptitude.',
    size: 'Small',
    speed: '30 ft.',
    traits: [
      Trait(
        name: 'Darkvision',
        description: 'You can see in dim light and darkness up to 60 feet.',
      ),
      Trait(
        name: 'Gnomish Cunning',
        description:
            'You have Advantage on Intelligence, Wisdom, and Charisma saving throws.',
      ),
    ],
    lineages: {
      'Forest Gnome':
          'You know the Minor Illusion cantrip. You always have the Speak with Animals spell prepared and can cast it without a spell slot.',
      'Rock Gnome':
          'You know the Mending and Prestidigitation cantrips. You can use Prestidigitation to create tiny clockwork devices.',
    },
  ),
  'Goliath': Species(
    name: 'Goliath',
    description:
        'Goliaths are massive humanoids who trace their ancestry back to the giants of the ancient world.',
    size: 'Medium',
    speed: '35 ft.',
    lineageLabel: 'Giant Ancestry',
    traits: [
      Trait(
        name: 'Powerful Build',
        description:
            'You have Advantage on any ability check you make to end the Grappled condition. You count as one size larger when determining your carrying capacity.',
      ),
      Trait(
        name: 'Large Form',
        description:
            'At level 5, as a Bonus Action, you can change your size to Large for 10 minutes. You gain Advantage on Strength checks and your Speed increases by 10 feet.',
      ),
    ],
    lineages: {
      'Cloud Giant':
          'You can magically teleport up to 30 feet to an unoccupied space you can see.',
      'Fire Giant':
          'You can deal extra Fire damage when you hit with an attack.',
      'Frost Giant':
          'You can deal extra Cold damage and reduce the target\'s Speed to 0.',
      'Hill Giant':
          'You can knock a Large or smaller creature Prone when you hit them.',
      'Stone Giant':
          'You can use your Reaction to reduce bludgeoning, piercing, or slashing damage you take.',
      'Storm Giant':
          'You can use your Reaction to deal Lightning damage to a creature that hits you.',
    },
  ),
  'Halfling': Species(
    name: 'Halfling',
    description:
        'Halflings are small, cheerful, and curious people who easily survive in a world full of larger creatures.',
    size: 'Small',
    speed: '30 ft.',
    traits: [
      Trait(
        name: 'Brave',
        description:
            'You have Advantage on saving throws against or to end the Frightened condition.',
      ),
      Trait(
        name: 'Halfling Nimbleness',
        description:
            'You can move through the space of any creature that is of a size larger than yours.',
      ),
      Trait(
        name: 'Luck',
        description:
            'When you roll a 1 on the d20 of a d20 Test, you can reroll the die, and you must use the new roll.',
      ),
      Trait(
        name: 'Naturally Stealthy',
        description:
            'You can take the Hide action even when you are obscured only by a creature that is at least one size larger than you.',
      ),
    ],
    lineages: {},
  ),
  'Human': Species(
    name: 'Human',
    description:
        'Humans are the most adaptable and ambitious people among the common species, known for their versatility.',
    size: 'Medium or Small',
    speed: '30 ft.',
    traits: [
      Trait(
        name: 'Resourceful',
        description:
            'You gain Heroic Inspiration whenever you finish a Long Rest.',
      ),
      Trait(
        name: 'Skillful',
        description: 'You gain proficiency in one skill of your choice.',
      ),
      Trait(
        name: 'Versatile',
        description: 'You gain an Origin Feat of your choice.',
      ),
    ],
    lineages: {},
  ),
  'Orc': Species(
    name: 'Orc',
    description:
        'Built for brawn and endurance, Orcs are naturally muscular and boast a relentless drive to survive.',
    size: 'Medium',
    speed: '30 ft.',
    traits: [
      Trait(
        name: 'Darkvision',
        description: 'You can see in dim light and darkness up to 120 feet.',
      ),
      Trait(
        name: 'Adrenaline Rush',
        description:
            'You can take the Dash action as a Bonus Action. When you do, you gain Temporary Hit Points equal to your Proficiency Bonus.',
      ),
      Trait(
        name: 'Relentless Endurance',
        description:
            'When you are reduced to 0 Hit Points but not killed outright, you can drop to 1 Hit Point instead. Once per Long Rest.',
      ),
    ],
    lineages: {},
  ),
  'Tiefling': Species(
    name: 'Tiefling',
    description:
        'To be greeted with stares and whispers, to suffer violence and insult on the street: this is the lot of the tiefling.',
    size: 'Medium or Small',
    speed: '30 ft.',
    lineageLabel: 'Fiendish Legacy',
    traits: [
      Trait(
        name: 'Darkvision',
        description: 'You can see in dim light and darkness up to 60 feet.',
      ),
      Trait(
        name: 'Otherworldly Presence',
        description: 'You know the Thaumaturgy cantrip.',
      ),
    ],
    lineages: {
      'Abyssal':
          'You have Resistance to Poison damage. You know the Poison Spray cantrip. At higher levels, you learn Ray of Sickness and Hold Person.',
      'Chthonic':
          'You have Resistance to Necrotic damage. You know the Chill Touch cantrip. At higher levels, you learn False Life and Ray of Enfeeblement.',
      'Infernal':
          'You have Resistance to Fire damage. You know the Fire Bolt cantrip. At higher levels, you learn Hellish Rebuke and Darkness.',
    },
  ),
};
