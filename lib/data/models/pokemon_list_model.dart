class PokemonListModel {
  final int count;
  final String next;
  final String previous;
  final List<PokemonListItemModel> pokemons;
  final bool isFirstPage;
  final bool hasNextPage;
  final int offSet;

  const PokemonListModel({
    required this.count,
    this.next = '',
    this.previous = '',
    required this.pokemons,
    this.isFirstPage = true,
    this.hasNextPage = false,
    this.offSet = 0,
  });

  factory PokemonListModel.fromJson(Map<String, dynamic> json) {
    return PokemonListModel(
        count: json['count'] as int,
        next: json['next'] as String,
        previous: (json['previous'] == null ? '' : json['previous'] as String),
        pokemons: (json['results'] as List)
            .map((e) => PokemonListItemModel.fromJson(e))
            .toList(),
        hasNextPage: json['next'] != null,
        isFirstPage: json['previous'] == null);
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
