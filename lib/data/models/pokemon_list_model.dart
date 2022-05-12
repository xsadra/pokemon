class PokemonListModel {
  final int count;
  final String next;
  final String previous;
  final List<PokemonListItemModel> pokemons;

  const PokemonListModel({
    required this.count,
    this.next = '',
    this.previous = '',
    required this.pokemons,
  });

  Map<String, dynamic> toJson() {
    return {
      'count': count,
      'next': next,
      'previous': previous,
      'pokemons': pokemons,
    };
  }

  factory PokemonListModel.fromJson(Map<String, dynamic> map) {
    return PokemonListModel(
      count: map['count'] as int,
      next: map['next'] as String,
      previous: (map['previous'] == null ? '' : map['previous'] as String),
      pokemons: (map['results'] as List)
          .map((e) => PokemonListItemModel.fromJson(e))
          .toList(),
    );
  }

  @override
  String toString() {
    return 'PokemonList{count: $count, next: $next, previous: $previous, pokemons: $pokemons}';
  }
}

class PokemonListItemModel {
  final String name;
  final String url;

  const PokemonListItemModel({
    required this.name,
    required this.url,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'url': url,
    };
  }

  factory PokemonListItemModel.fromJson(Map<String, dynamic> map) {
    return PokemonListItemModel(
      name: map['name'] as String,
      url: map['url'] as String,
    );
  }

  @override
  String toString() {
    return 'PokemonListItem{next: $name, url: $url}';
  }
}
