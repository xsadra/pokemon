import 'package:meta/meta.dart';

@immutable
abstract class PokemonEvent {}

class GetPokemonEvent extends PokemonEvent {}
