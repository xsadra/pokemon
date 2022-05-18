import 'package:flutter/material.dart';

import '../../core/core.dart';
import '../widgets/widgets.dart';

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
