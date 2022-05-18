import 'package:flutter/foundation.dart' show immutable;
import 'package:pokemon/domain/entities/entities.dart';

@immutable
abstract class PokemonState {}

class Empty extends PokemonState {}

class Loading extends PokemonState {
  final bool isFirstFetch;
  final List<Pokemon> pokemons;

  Loading({
    required this.isFirstFetch,
    required this.pokemons,
  });
}

class Loaded extends PokemonState {
  final Pokemons pokemons;

  Loaded({
    required this.pokemons,
  });
}

class Error extends PokemonState {
  final String message;

  Error({
    required this.message,
  });
}
