import 'dart:developer';

import 'package:dio/dio.dart';

import '../../core/constants/consts.dart';
import '../../core/error/exceptions.dart';

abstract class SpeciesRemoteDataSource {
  Future<String> getSpecies(int id);
}

class SpeciesRemoteDataSourceImpl implements SpeciesRemoteDataSource {
  final Dio dio;

  SpeciesRemoteDataSourceImpl({
    required this.dio,
  });

  @override
  Future<String> getSpecies(int id) async {
    final response = await dio
        .get(
          App.api.speciesBaseApiUrl + id.toString(),
          options: Options(headers: {
            'Content-Type': 'application/json',
          }),
        )
        .timeout(const Duration(seconds: 30))
        .catchError((onError) {
      throw ServerException();
    });

    String species = (response.data['name'] as String);
    log(species, name: 'SpeciesRemoteDataSourceImpl');
    return species;
  }
}
