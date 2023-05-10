import 'package:flutter/material.dart';
import 'package:pokemon_pokedex/src/pages/Principal/home_principal.dart';
import 'package:pokemon_pokedex/src/pages/Principal/pokemonGrid.dart';

Map<String, WidgetBuilder> rutas() {
  return <String, WidgetBuilder>{
    'homePokedex': (context) => HomePrincipal(),
    'homePokemonGrid': (context) => HomepokemonGrid(
          url: '',
        )
  };
}
