import 'package:dartz/dartz.dart';
import 'package:pokemon/domain/entities/pokemons.dart';

import '../../core/core.dart';
import '../../domain/entities/pokemon.dart';
import '../datasources/dataSources.dart';

abstract class PokemonRepository {
  Future<Either<Failure, Pokemons>> getPokemons({required int offSet});
}

class PokemonRepositoryImpl implements PokemonRepository {
  final NetworkInfo networkInfo;
  final PokemonListRemoteDataSource pokemonListDataSource;
  final PokemonRemoteDataSource pokemonDataSource;
  final ShapesRemoteDataSource shapesDataSource;
  final SpeciesRemoteDataSource speciesDataSource;

  PokemonRepositoryImpl({
    required this.networkInfo,
    required this.pokemonListDataSource,
    required this.pokemonDataSource,
    required this.shapesDataSource,
    required this.speciesDataSource,
  });

  @override
  Future<Either<Failure, Pokemons>> getPokemons({required int offSet}) async {
    if (await networkInfo.isConnected) {
      logShort.i('Device has Internet connection', 'PokemonRepository');
      logShort.i('OffSet: $offSet', 'PokemonRepository');
      try {
        final pokemonList =
            await pokemonListDataSource.getPokemons(offSet: offSet);

        var pokemons = <Pokemon>[];
        pokemonList.pokemons.forEach((element) async {
          final pokemon = await _getPokemon(element.url);
          pokemons.add(pokemon);
        });

        logShort.i(
            pokemons.map((e) => e.toString()).join('\n'), 'PokemonRepository');
        return right(Pokemons(
          items: pokemons,
          hasNextPage: pokemonList.hasNextPage,
          offSet: offSet,
        )..increaseOffSet());
      } on ServerException {
        return Left(ServerFailure());
      }
    }
    logShort.e('No Internet connection', 'PokemonRepository');
    return Left(NoInternetFailure());
  }

  Future<Pokemon> _getPokemon(String url) async {
    if (await networkInfo.isConnected) {
      return await pokemonDataSource.getPokemon(url);
    }
    throw NoInternetException();
  }

  Future<String> _getShapesName(int id) async {
    if (await networkInfo.isConnected) {
      return await shapesDataSource.getShapes(id);
    }
    throw NoInternetException();
  }

  Future<String> _getSpeciesName(int id) async {
    if (await networkInfo.isConnected) {
      return await speciesDataSource.getSpecies(id);
    }
    throw NoInternetException();
  }
}
