class Trait {
  final String name;
  final String description;

  const Trait({required this.name, required this.description});
}

class Species {
  final String name;
  final String description;
  final String size;
  final String speed;
  final List<Trait> traits;
  final Map<String, String> lineages; // e.g., 'High Elf': 'Description...'
  final String lineageLabel; // e.g., 'Lineage', 'Draconic Ancestry'

  const Species({
    required this.name,
    required this.description,
    required this.size,
    required this.speed,
    required this.traits,
    required this.lineages,
    this.lineageLabel = 'Lineage',
  });
}
