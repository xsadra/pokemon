import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon/core/core.dart';

import '../../../data/repository/pokemon_list_repository.dart';
import '../../../domain/entities/entities.dart';
import 'bloc.dart';

class PokemonBloc extends Bloc<PokemonEvent, PokemonState> {
  final PokemonRepository _repository;
  int page = 0;
  List<Pokemon> currentList = [];

  PokemonBloc({required PokemonRepository repository})
      : _repository = repository,
        super(Empty());

  @override
  Stream<PokemonState> mapEventToState(PokemonEvent event) async* {
    if (event is GetPokemonEvent) {
      logShort.i('Loading', 'PokemonBloc');
      yield Loading(isFirstFetch: currentList.isEmpty, pokemons: currentList);
      logShort.i('getPokemons', 'PokemonBloc');
      final failureOrPokemons = await _repository.getPokemons(
          offSet: App.api.itemPrePage * page, oldList: currentList);
      page++;
      logShort.i('getBattles fold', 'PokemonBloc');
      yield failureOrPokemons.fold(
        (failure) => Error(message: failure.toMessage),
        (pokemons) {
          currentList = List.castFrom(pokemons.items);
          return Loaded(pokemons: pokemons);
        },
      );
    } else {
      logShort.e('Unexpected event', 'PokemonBloc');
      yield Error(message: App.error.unexpectedEvent);
    }
  }
}
