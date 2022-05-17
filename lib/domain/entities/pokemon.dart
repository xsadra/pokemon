class Pokemon {
  final String name;
  final String? image;
  final int? id;
  final int? baseExperience;
  final int? height;
  final int? order;
  final int? weight;
  final String? shapes;
  final String? species;

  const Pokemon({
    required this.name,
    this.image,
    this.id,
    this.baseExperience,
    this.height,
    this.order,
    this.weight,
    this.shapes,
    this.species,
  });

  Pokemon copyWith({
    String? name,
    String? image,
    int? id,
    int? baseExperience,
    int? height,
    int? order,
    int? weight,
    String? shapes,
    String? species,
  }) {
    return Pokemon(
      name: name ?? this.name,
      image: image ?? this.image,
      id: id ?? this.id,
      baseExperience: baseExperience ?? this.baseExperience,
      height: height ?? this.height,
      order: order ?? this.order,
      weight: weight ?? this.weight,
      shapes: shapes ?? this.shapes,
      species: species ?? this.species,
    );
  }
}
