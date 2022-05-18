import 'package:flutter/material.dart';

import '../../domain/entities/entities.dart';

class PokemonListViewItem extends StatelessWidget {
  const PokemonListViewItem({
    Key? key,
    required this.pokemon,
  }) : super(key: key);

  final Pokemon pokemon;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10),
        Row(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Positioned(
                  child: CircleAvatar(
                    radius: 35,
                    backgroundColor: Colors.blueGrey.shade100,
                    child: Image.network(
                      pokemon.image!,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                Positioned(
                  right: -20,
                  bottom: 0,
                  child: CircleAvatar(
                    radius: 15,
                    backgroundColor: Colors.blueGrey.shade100,
                    child: Text(pokemon.id.toString(),
                        style: TextStyle(
                          color: Colors.deepOrangeAccent,
                          fontSize: _getFontSizeBaseOnIdLength(),
                        )),
                  ),
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text(pokemon.name,
                      style: const TextStyle(
                        color: Colors.black87,
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      )),
                ),
                const SizedBox(height: 30),
                //Text(pokemon.id.toString()),
              ],
            ),
          ],
        ),
        const SizedBox(height: 10),
        Container(
          height: 0.5,
          margin: const EdgeInsets.only(left: 70.0),
          width: double.infinity,
          color: Colors.black45,
        ),
      ],
    );
  }

  double _getFontSizeBaseOnIdLength() {
    switch (pokemon.id.toString().length) {
      case 1:
        return 25;
      case 2:
        return 18;
      case 3:
        return 12;
      case 4:
        return 10;
    }
    return 10;
  }
}
