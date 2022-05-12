import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart' show GetIt;

import 'data/datasources/dataSources.dart';
import 'data/repository/pokemon_list_repository.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // sl.registerFactory(
  //   () => PokemonBloc(upcomingChests: sl()),
  // );

  sl.registerLazySingleton<PokemonRepository>(
    () => PokemonRepositoryImpl(
      pokemonListRemoteDataSource: sl(),
      pokemonRemoteDataSource: sl(),
      //  networkInfo: sl(),
      speciesRemoteDataSource: sl(),
      shapesRemoteDataSource: sl(),
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

  // sl.registerLazySingleton<NetworkInfo>(
  //   () => NetworkInfoImpl(sl()),
  // );

  sl.registerLazySingleton(() => Dio());

  // sl.registerLazySingleton(() => DataConnectionChecker());
}
