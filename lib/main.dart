import 'package:flutter/material.dart' hide Router;
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/routes/router.dart';
import 'injection_container.dart' as injection;
import 'presentation/bloc/pokemon/bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await injection.init();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _router = Router();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => injection.sl<PokemonBloc>()..add(GetPokemonEvent()),
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routeInformationParser: _router.defaultRouteParser(),
        routerDelegate: _router.delegate(),
      ),
    );
  }
}
