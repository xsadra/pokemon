import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon/core/routes/router.dart';

import '../../core/core.dart';
import '../../domain/entities/entities.dart';
import '../bloc/pokemon/bloc.dart';
import 'widgets.dart';

class PokemonListView extends StatelessWidget {
  PokemonListView(BuildContext context, {Key? key}) : super(key: key);
  final _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    _setupScrollController(context);
    return BlocBuilder<PokemonBloc, PokemonState>(
      builder: (context, state) {
        logShort.wtf(state.runtimeType, PokemonListView);
        if (state is Loaded) {
          Pokemons pokemons = state.pokemons;
          List<Pokemon> items = pokemons.items;

          return _buildListView(items);
        } else if (state is Error) {
          return Center(child: Text(state.message));
        } else if (state is Loading) {
          return state.isFirstFetch
              ? const Center(child: CircularProgressIndicator())
              : _buildListView(state.pokemons, isLoading: true);
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  void _setupScrollController(BuildContext context) {
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        context.read<PokemonBloc>().add(GetPokemonEvent());
      }
    });
  }

  ListView _buildListView(List<Pokemon> items, {bool isLoading = false}) {
    return ListView.builder(
      controller: _scrollController,
      itemCount: isLoading ? items.length + 1 : items.length,
      padding: const EdgeInsets.all(3.0),
      itemBuilder: (context, index) {
        if (isLoading && items.length == index) {
          Timer(
              const Duration(milliseconds: 20),
              () => _scrollController
                  .jumpTo(_scrollController.position.maxScrollExtent));
          return const Center(child: CircularProgressIndicator());
        }

        return TextButton(
            onPressed: () => context.router.push(
                  DetailsRoute(pokemon: items[index]),
                ),
            child: PokemonListViewItem(pokemon: items[index]));
      },
    );
  }
}
