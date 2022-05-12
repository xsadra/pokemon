import 'dart:developer';

import 'package:flutter/material.dart';

import 'data/repository/pokemon_list_repository.dart';
import 'domain/entities/Pokemon.dart';
import 'injection_container.dart' as injection;

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
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Pokemon> items = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pokemon'),
      ),
      body: Scrollbar(
        child: items.isEmpty
            ? Center(
                child: Column(
                children: [
                  const CircularProgressIndicator(),
                  ElevatedButton(
                      onPressed: () {
                        setState(() {});
                      },
                      child: const Text('Load'))
                ],
              ))
            : ListView.builder(
                // controller: controller,
                itemBuilder: (context, index) {
                  var item = items[index];
                  //
                  return ListTile(
                    title: Text(item.name),
                    subtitle: Text(item.id.toString()),
                    leading: Image.network(item.image!),
                    onTap: () => _onTap(item),
                  );
                },
                itemCount: items.length,
              ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  @override
  void initState() {
    _incrementCounter();
  }

  _incrementCounter() async {
    log('Start');
    items = await injection.sl<PokemonRepository>().getPokemons();
    log('Set State');
    setState(() {});
  }

  void _onTap(Pokemon item) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Detail(item: item)),
    );
  }
}

class Detail extends StatelessWidget {
  Detail({Key? key, required this.item}) : super(key: key);
  final Pokemon item;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height / 3;
    return Scaffold(
      appBar: AppBar(title: Text(item.name)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(height: height, child: Image.network(item.image!)),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [const Text('Name:'), Text(item.name)]),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [const Text('Id:'), Text(item.id.toString())]),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              const Text('Height:'),
              Text(item.height.toString())
            ]),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              const Text('Weight:'),
              Text(item.weight.toString())
            ]),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [const Text('Order:'), Text(item.order.toString())]),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [const Text('Species:'), Text(item.species ?? '')]),
            SizedBox(
              height: height,
            )
          ],
        ),
      ),
    );
  }
}
