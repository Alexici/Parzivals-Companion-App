class ClassFeature {
  final String name;
  final String description;

  const ClassFeature({required this.name, required this.description});
}

class CharacterClass {
  final String name;
  final String description;
  final String hitDice;
  final String primaryAbility;
  final String saves;
  final List<ClassFeature> level1Features;

  const CharacterClass({
    required this.name,
    required this.description,
    required this.hitDice,
    required this.primaryAbility,
    required this.saves,
    required this.level1Features,
  });
}
