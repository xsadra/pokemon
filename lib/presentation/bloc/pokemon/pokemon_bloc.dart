import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon/core/core.dart';

import '../../../data/repository/pokemon_list_repository.dart';
import 'bloc.dart';

class PokemonBloc extends Bloc<PokemonEvent, PokemonState> {
  final PokemonRepository _repository;

  PokemonBloc({required PokemonRepository repository})
      : _repository = repository,
        super(Empty());

  @override
  Stream<PokemonState> mapEventToState(PokemonEvent event) async* {
    if (event is GetPokemonEvent) {
      logShort.i('Loading', 'PokemonBloc');
      yield Loading();
      logShort.i('getPokemons', 'PokemonBloc');
      final failureOrPokemons =
          await _repository.getPokemons(offSet: event.offSet);
      logShort.i('getBattles fold', 'PokemonBloc');
      yield failureOrPokemons.fold(
        (failure) => Error(message: failure.toMessage),
        (pokemons) => Loaded(pokemons: pokemons),
      );
    } else {
      logShort.e('Unexpected event', 'PokemonBloc');
      yield Error(message: App.error.unexpectedEvent);
    }
  }
}
