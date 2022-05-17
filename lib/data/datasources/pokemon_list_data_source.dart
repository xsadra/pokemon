import 'dart:developer';

import 'package:dio/dio.dart';

import '../../core/core.dart';
import '../models/pokemon_list_model.dart';

abstract class PokemonListRemoteDataSource {
  Future<PokemonListModel> getPokemons({required int offSet});
}

class PokemonListRemoteDataSourceImpl implements PokemonListRemoteDataSource {
  final Dio dio;

  PokemonListRemoteDataSourceImpl({
    required this.dio,
  });

  @override
  Future<PokemonListModel> getPokemons({required int offSet}) async {
    final response = await dio
        .get(
          App.api.pokemonListApiUrlWithOffset(offSet),
          options: Options(headers: {
            'Content-Type': 'application/json',
          }),
        )
        .timeout(const Duration(seconds: 30))
        .catchError((onError) {
      throw ServerException();
    });

    PokemonListModel pokemonList = PokemonListModel.fromJson(response.data);
    log(pokemonList.toString(), name: 'PokemonRemoteDataSourceImpl');

    return pokemonList;
  }
}
