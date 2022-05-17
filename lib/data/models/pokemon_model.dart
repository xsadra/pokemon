import '../../domain/entities/Pokemon.dart';

class PokemonModel extends Pokemon {
  PokemonModel({
    required String name,
    String? image,
    int? id,
    int? baseExperience,
    int? height,
    int? order,
    int? weight,
    String? shapes,
    String? species,
  }) : super(
          name: name,
          baseExperience: baseExperience,
          height: height,
          id: id,
          image: image,
          order: order,
          shapes: shapes,
          species: species,
          weight: weight,
        );

  @override
  String toString() {
    return 'Pokemon{name: $name, image: $image, id: $id, baseExperience: $baseExperience, height: $height, order: $order, weight: $weight, shapes: $shapes, species: $species}';
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'image': image,
      'id': id,
      'base_experience': baseExperience,
      'height': height,
      'order': order,
      'weight': weight,
      'shapes': shapes,
      'species': species,
    };
  }

  factory PokemonModel.fromJson(Map<String, dynamic> json) {
    return PokemonModel(
      name: json['name'] as String,
      image: (json['sprites']['front_default'] == null
          ? ''
          : json['sprites']['front_default'] as String),
      id: json['id'] as int,
      baseExperience:
          json['base_experience'] == null ? 0 : json['base_experience'] as int,
      height: json['height'] as int,
      order: json['order'] as int,
      weight: json['weight'] as int,
      // shapes: json['shapes'] == null ? '' : json['shapes'] as String,
      species: json['species']['name'] == null
          ? ''
          : json['species']['name'] as String,
      shapes: '',
    );
  }

  @override
  PokemonModel copyWith({
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
    return PokemonModel(
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
