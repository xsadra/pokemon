import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

class DetailsPage extends StatelessWidget {
  const DetailsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          const Text('Details'),
          ElevatedButton(
              onPressed: () {
                context.router.pop();
              },
              child: Icon(Icons.skip_previous))
        ],
      ),
    );
  }
}
