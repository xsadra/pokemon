import 'package:flutter/material.dart';

import '../../domain/entities/entities.dart';
import '../widgets/widgets.dart';

class DetailsPage extends StatelessWidget {
  const DetailsPage({Key? key, required this.pokemon}) : super(key: key);

  final Pokemon pokemon;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(title: Text(pokemon.name)),
      body: SizedBox(
        height: height,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: height / 4,
                  child: Image.network(
                    pokemon.image!,
                    fit: BoxFit.fill,
                  ),
                ),
                SizedBox(
                  height: height / 12,
                  child: Text(pokemon.name,
                      style: TextStyle(
                          color: Colors.green.shade800,
                          fontSize: 35,
                          fontWeight: FontWeight.bold)),
                ),
                ShowText(title: 'Id', value: pokemon.id.toString()),
                ShowText(title: 'Order', value: pokemon.order.toString()),
                ShowText(title: 'Height', value: pokemon.height.toString()),
                ShowText(title: 'Weight', value: pokemon.weight.toString()),
                ShowText(title: 'Species', value: pokemon.species.toString()),
                ShowText(
                    title: 'Base Ex', value: pokemon.baseExperience.toString()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
