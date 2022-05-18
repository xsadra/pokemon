import 'dart:async';

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
        child: PokemonListView(context),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: Text(App.ui.appTitle),
    );
  }
}

class PokemonListView extends StatelessWidget {
  PokemonListView(BuildContext context, {Key? key}) : super(key: key);
  final _scrollController = ScrollController();

  void _setupScrollController(BuildContext context) {
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        context.read<PokemonBloc>().add(GetPokemonEvent());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    _setupScrollController(context);
    return BlocBuilder<PokemonBloc, PokemonState>(
      builder: (context, state) {
        logShort.wtf(state.runtimeType, PokemonListView);
        if (state is Loaded) {
          Pokemons pokemons = state.pokemons;
          List<Pokemon> items = pokemons.items;

          return _buildListView2(items);
        } else if (state is Error) {
          return Center(child: Text(state.message));
        } else if (state is Loading) {
          return state.isFirstFetch
              ? const Center(child: CircularProgressIndicator())
              : _buildListView2(state.pokemons, isLoading: true);
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  ListView _buildListView2(
    List<Pokemon> items, {
    bool isLoading = false,
  }) {
    return ListView.builder(
      controller: _scrollController,
      itemCount: isLoading ? items.length + 1 : items.length,
      itemBuilder: (context, index) {
        if (isLoading && items.length == index) {
          Timer(
              const Duration(milliseconds: 20),
              () => _scrollController
                  .jumpTo(_scrollController.position.maxScrollExtent));
          return const Center(child: CircularProgressIndicator());
        }
        Pokemon pokemon = items[index];
        return Padding(
          padding: const EdgeInsets.all(00.0),
          child: Text(pokemon.name),
        );
      },
    );
  }

  ListView _buildListView(
    List<Pokemon> items, {
    bool isLoading = false,
    required ScrollController controller,
  }) {
    return ListView.builder(
      controller: controller,
      itemCount: isLoading ? items.length + 1 : items.length,
      itemBuilder: (context, index) {
        if (isLoading && items.length == index) {
          Timer(
              const Duration(milliseconds: 20),
              () => _scrollController
                  .jumpTo(_scrollController.position.maxScrollExtent));
          return const Center(child: CircularProgressIndicator());
        }
        Pokemon pokemon = items[index];
        return Padding(
          padding: const EdgeInsets.all(00.0),
          child: Row(
            children: [
              Text(pokemon.name),
              ElevatedButton(
                  onPressed: () {
                    context.read<PokemonBloc>().add(GetPokemonEvent());
                  },
                  child: const Icon(Icons.add))
            ],
          ),
        );
      },
    );
  }
}
