import 'dart:developer';

import '../../core/core.dart';
import '../../domain/entities/Pokemon.dart';
import '../datasources/dataSources.dart';

abstract class PokemonRepository {
  Future<List<Pokemon>> getPokemons();
}

class PokemonRepositoryImpl implements PokemonRepository {
  //final NetworkInfo networkInfo;
  final PokemonListRemoteDataSource pokemonListRemoteDataSource;
  final PokemonRemoteDataSource pokemonRemoteDataSource;
  final ShapesRemoteDataSource shapesRemoteDataSource;
  final SpeciesRemoteDataSource speciesRemoteDataSource;

  PokemonRepositoryImpl({
    // required this.networkInfo,
    required this.pokemonListRemoteDataSource,
    required this.pokemonRemoteDataSource,
    required this.shapesRemoteDataSource,
    required this.speciesRemoteDataSource,
  });

  @override
  Future<List<Pokemon>> getPokemons() async {
    // if (await networkInfo.isConnected) {
    try {
      final remotePokemonList = await pokemonListRemoteDataSource.getPokemons();

      var pokemonList = <Pokemon>[];
      // remotePokemonList.pokemons.map((e) =>  _itemToPokemon(e)).toList();
      remotePokemonList.pokemons.forEach((element) async {
        final pokemon = await _getPokemon(element.url);
        // var shapes = await _getShapesName(pokemon.id!);
        // var species = await _getSpeciesName(pokemon.id!);
        // pokemon.copyWith(
        //   //    species: species,
        // //  shapes: shapes,
        // );
        pokemonList.add(pokemon);
      });
      log('----------result------');
      log(pokemonList.map((e) => e.toString()).join(' \n\n\n '));
      return pokemonList;
    } on ServerException {
      return [];
    }
    // }
    //
    // Left(NoInternetFailure());
  }

// Future<Pokemon> _itemToPokemon(PokemonListItemModel e) async {
//     final pokemon =
//     await pokemonRemoteDataSource.getPokemon(e.url);
//     var shapes = await shapesRemoteDataSource.getShapes(pokemon.id!);
//     var species = await speciesRemoteDataSource.getSpecies(pokemon.id!);
//     pokemon.copyWith(species: species, shapes: shapes);
//     return pokemon;
// }

  Future<Pokemon> _getPokemon(String url) async {
    // if (await networkInfo.isConnected) {
    return await pokemonRemoteDataSource.getPokemon(url);
    // }
    //throw NoInternetException();
  }

  Future<String> _getShapesName(int id) async {
    //if (await networkInfo.isConnected) {
    return await shapesRemoteDataSource.getShapes(id);
    //}
    // throw NoInternetException();
  }

  Future<String> _getSpeciesName(int id) async {
    //   if (await networkInfo.isConnected) {
    return await speciesRemoteDataSource.getSpecies(id);
    //  }
    //  throw NoInternetException();
  }
}
