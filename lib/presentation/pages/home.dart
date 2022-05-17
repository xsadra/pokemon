import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/core.dart';
import '../../domain/entities/entities.dart';
import '../bloc/pokemon/bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<PokemonBloc, PokemonState>(
          builder: (context, state) {
            if (state is Loaded) {
              Pokemons pokemons = state.pokemons;
              List<Pokemon> items = pokemons.items;
              return ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  Pokemon pokemon = items[index];
                  return Text(pokemon.name);
                },
              );
            } else if (state is Error) {
              return Center(child: Text(state.message));
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: Text(App.ui.appTitle),
    );
  }
}
