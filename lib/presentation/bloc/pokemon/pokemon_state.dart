import 'package:flutter/foundation.dart' show immutable;

import '../../../domain/entities/Pokemon.dart';

@immutable
abstract class PokemonState {}

class Empty extends PokemonState {}

class Loading extends PokemonState {}

class Loaded extends PokemonState {
  final List<Pokemon> pokemons;

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
