import 'package:flutter/foundation.dart';

@immutable
abstract class PokemonEvent {}

class GetPokemonEvent extends PokemonEvent {
  final int offSet;

  GetPokemonEvent({required this.offSet});
}
