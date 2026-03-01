### THE ORIGINS

1. Name - String
2. Race - String (from list)
3. Subrace - String (from list)
4. Gender - String (from list)

### The Class

1. CharacterClass - String (from list)
2. Level - Integer (defaults to 1 for character creation)

### The Background (all optional?)

1. BackgroundName - String (from list or custom)
2. Alignment - String (from list)
3. Age - Integer
4. Height - String or Integer
5. Weight - String or Integer
6. Eyes - String
7. Skin - String
8. Hair - String
9. PersonalityTraits - String
10. Ideals - String
11. Bonds - String
12. Flaws - String
13. Backstory - String (autocompletes from BackgroundName or custom)

### The Abilities

1. GenerationMethod - Enum (standardArray, pointBuy, manualRolled)
2. baseStr, baseDex, baseCon, baseInt, baseWis, baseCha - Integer
3. bonusStr, bonusDex, bonusCon, bonusInt, bonusWis, bonusCha - Integer
4. modifierStr, modifierDex, modifierCon, modifierInt, modifierWis, modifierCha - Integer
5. finalStr, finalDex, finalCon, finalInt, finalWis, finalCha - Integer
6. otherModStr.... - Integer

### The Equipment

1. startingEquipment - List<String>
2. startingGold - Integer
3. personalPossesions - List<String>

### OTHER DATA

1. currentHP - Integer
2. maxHp - Integer
3. tempHp - Integer
4. hitDice - String (eg: 1d12)
5. languages - List<String>
6. initiative - Integer
7. armorClass - Integer
8. defenses - List<String>
9. conditions - List<String>
10. walking - Integer
11. toolProficiency - List<String>
12. weaponProficiency - List<String> (martial, simple or firearms)
13. armorProficiency - List<String>
14. passivePerception - Integer
15. passiveInvestigation - Integer
16. passiveInsight - Integer
17. proficiencyBonus - Integer

### DON'T KNOW WHAT KIND OF DATA TO ADD / HOW TO SORT

1. classFeatures
2. feats
3. skills (proficiency - bool, modifier - string, bonus - int, name? - String)
4. darkvision (maybe a flag and another entry for range?)

### RACE RELATED DATA

- need to add

### CLASS RELATED DATA

- need to add

### EQUIPMENT / ITEMS DATA (this data is in all the item types)

1. itemName - String
2. itemType - String (there will be a list called itemTypes or something simiar with the following types: armor, potion, ring, rod, scroll, staff, wand, weapon, wondrous, other gear)
3. (on the dndbeyond inventory there are other flags such as proficient, common, magical & container so maybe add them as flags / booleans)
4. avgCost - Integer (I don't know how to feel about this one to be honest)
5. description - String
6. tags - List<String> (I don't really know the usefullness of this one yet. Maybe for filters?)
7. source - String (idk if it is necessary)
8. itemRarity - String (from a set list of item rarities)

### ITEM TYPES SPECIAL DATA

## ARMOR

1. armorClass - Integer

## POTION

## RING

## ROD

## SCROLL

1. spellSlotLevel - String? (0 for cantrip and the rest for spell slot levels)

## STAFF

## WEAPON

1. attackType - String (Melee or Ranged)
2. reach - String or Integer
3. damage - String or Integer (I don't know how we will calculate damage yet)
4. damageType - List<String> or String
5. properties - String

## WONDROUS

## OTHER GEAR

## THINGS WE WONT ADD

1. Attunment
2. Inventory Weight
