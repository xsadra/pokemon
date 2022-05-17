import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart' show GetIt;
import 'package:internet_connection_checker/internet_connection_checker.dart';

import 'core/core.dart';
import 'data/datasources/dataSources.dart';
import 'data/repository/pokemon_list_repository.dart';
import 'presentation/bloc/pokemon/bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerFactory(
    () => PokemonBloc(repository: sl()),
  );

  sl.registerLazySingleton<PokemonRepository>(
    () => PokemonRepositoryImpl(
      pokemonListDataSource: sl(),
      pokemonDataSource: sl(),
      networkInfo: sl(),
      speciesDataSource: sl(),
      shapesDataSource: sl(),
    ),
  );

  sl.registerLazySingleton<SpeciesRemoteDataSource>(
    () => SpeciesRemoteDataSourceImpl(dio: sl()),
  );

  sl.registerLazySingleton<ShapesRemoteDataSource>(
    () => ShapesRemoteDataSourceImpl(dio: sl()),
  );

  sl.registerLazySingleton<PokemonListRemoteDataSource>(
    () => PokemonListRemoteDataSourceImpl(dio: sl()),
  );

  sl.registerLazySingleton<PokemonRemoteDataSource>(
    () => PokemonRemoteDataSourceImpl(dio: sl()),
  );

  sl.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(sl()),
  );

  sl.registerLazySingleton(() => Dio());

  sl.registerLazySingleton(() => InternetConnectionChecker());
}
