import '../../core/core.dart';
import 'pokemon.dart';

class Pokemons {
  final List<Pokemon> items;
  final bool hasNextPage;
  final int offSet;

  const Pokemons({
    required this.items,
    required this.hasNextPage,
    required this.offSet,
  });

  Pokemons copyWith({
    List<Pokemon>? items,
    bool? hasNextPage,
    int? offSet,
  }) {
    return Pokemons(
      items: items ?? this.items,
      hasNextPage: hasNextPage ?? this.hasNextPage,
      offSet: offSet ?? this.offSet,
    );
  }

  Pokemons increaseOffSet() {
    logs.i('Increasing OffSet');
    return Pokemons(
      items: items,
      hasNextPage: hasNextPage,
      offSet: offSet + App.api.itemPrePage,
    );
  }
}
