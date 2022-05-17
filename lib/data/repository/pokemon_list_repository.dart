import 'dart:developer';

import 'package:dartz/dartz.dart';

import '../../core/core.dart';
import '../../domain/entities/Pokemon.dart';
import '../datasources/dataSources.dart';

abstract class PokemonRepository {
  Future<Either<Failure, List<Pokemon>>> getPokemons();
}

class PokemonRepositoryImpl implements PokemonRepository {
  final NetworkInfo networkInfo;
  final PokemonListRemoteDataSource pokemonListRemoteDataSource;
  final PokemonRemoteDataSource pokemonRemoteDataSource;
  final ShapesRemoteDataSource shapesRemoteDataSource;
  final SpeciesRemoteDataSource speciesRemoteDataSource;

  PokemonRepositoryImpl({
    required this.networkInfo,
    required this.pokemonListRemoteDataSource,
    required this.pokemonRemoteDataSource,
    required this.shapesRemoteDataSource,
    required this.speciesRemoteDataSource,
  });

  @override
  Future<Either<Failure, List<Pokemon>>> getPokemons() async {
    if (await networkInfo.isConnected) {
      log('Device has Internet connection', name: 'PokemonRepositoryImpl');
      try {
        final remotePokemonList =
            await pokemonListRemoteDataSource.getPokemons();

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
        log('----------result------', name: 'PokemonRepositoryImpl');
        log(pokemonList.map((e) => e.toString()).join(' \n\n\n '),
            name: 'PokemonRepositoryImpl');
        return right(pokemonList);
      } on ServerException {
        return Left(ServerFailure());
      }
    }
    log('No Internet connection', name: 'PokemonRepositoryImpl');
    return Left(NoInternetFailure());
  }

  Future<Pokemon> _getPokemon(String url) async {
    if (await networkInfo.isConnected) {
      return await pokemonRemoteDataSource.getPokemon(url);
    }
    throw NoInternetException();
  }

  Future<String> _getShapesName(int id) async {
    if (await networkInfo.isConnected) {
      return await shapesRemoteDataSource.getShapes(id);
    }
    throw NoInternetException();
  }

  Future<String> _getSpeciesName(int id) async {
    if (await networkInfo.isConnected) {
      return await speciesRemoteDataSource.getSpecies(id);
    }
    throw NoInternetException();
  }
}
