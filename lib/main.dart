import 'package:flutter/material.dart';
import 'package:pokemon_pokedex/provider/provider_selection.dart';
import 'package:pokemon_pokedex/src/routes/routes.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = ThemeData();

    return MultiProvider(
        providers: [
          ChangeNotifierProvider<ProviderSelection>(
              create: (_) => ProviderSelection())
        ],
        builder: (context, _) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            initialRoute: 'homePokedex',
            routes: rutas(),
          );
        });
  }
}
