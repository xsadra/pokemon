import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:pokemon/core/routes/router.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          const Text('Home'),
          ElevatedButton(
              onPressed: () {
                context.router.push(const DetailsRoute());
              },
              child: const Icon(Icons.forward))
        ],
      ),
    );
  }
}
