import 'package:dio/dio.dart';

import '../../core/core.dart';
import '../../domain/entities/pokemon.dart';
import '../models/pokemon_model.dart';

abstract class PokemonRemoteDataSource {
  Future<Pokemon> getPokemon(String url);
}

class PokemonRemoteDataSourceImpl implements PokemonRemoteDataSource {
  final Dio dio;

  PokemonRemoteDataSourceImpl({
    required this.dio,
  });

  @override
  Future<Pokemon> getPokemon(String url) async {
    logShort.wtf(url, 'PokemonRemoteDataSource');
    final response = await dio
        .get(
          url,
          options: Options(headers: {
            'Content-Type': 'application/json',
          }),
        )
        .timeout(const Duration(seconds: 30))
        .catchError((onError) {
      throw ServerException();
    });

    PokemonModel pokemon = PokemonModel.fromJson(response.data);
    logShort.d(pokemon.toString(), 'PokemonRemoteDataSource');

    return pokemon;
  }
}
