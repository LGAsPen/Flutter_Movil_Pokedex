// ignore_for_file: prefer_is_empty

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:pokemon_pokedex/src/api/getData.dart';
import 'package:pokemon_pokedex/src/json/pokemType.dart';
import 'package:pokemon_pokedex/src/widgets/widgets.dart';

class HomePrincipal extends StatefulWidget {
  const HomePrincipal({Key? key}) : super(key: key);

  @override
  State<HomePrincipal> createState() => _HomePrincipalState();
}

class _HomePrincipalState extends State<HomePrincipal> {
  final Widgets _widgets = Widgets();
  static List<JsonPokemontype> listTypes = [];
  static List<JsonPokemontype> listGeneraciones = [];

  static bool banderaLoader = false;
  int _selectIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: _bottomNavigationBar(),
      body: Stack(
        children: [
          (_selectIndex != 2) ? pokemonFinder() : Container(),
        ],
      ),
    );
  }

  Widget _bottomNavigationBar() {
    return BottomNavigationBar(
      items: [
        _widgets.bottomNavigationBarItem("Generation", "pokebola-2.png"),
        _widgets.bottomNavigationBarItem("Type", "pokeball-3.png"),
        _widgets.bottomNavigationBarItem("About", "entrenador-pokemon.png"),
      ],
      currentIndex: _selectIndex,
      onTap: _onItemTapped,
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectIndex = index;
    });
  }

  pokemonFinder() {
    final size = MediaQuery.of(context).size;
    return Align(
      alignment: Alignment.bottomCenter,
      child: SizedBox(
        height: size.height * 0.2,
        child: FutureBuilder(
          future: (_selectIndex == 0)
              ? GetData().generationsPokemon()
              : GetData().typesPokemons(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              fillList("${snapshot.data}");
              return ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: (_selectIndex == 0)
                    ? listGeneraciones.length
                    : listTypes.length,
                itemBuilder: (context, index) {
                  return Container(
                    alignment: Alignment.center,
                    width: size.width * 0.25,
                    margin: const EdgeInsets.all(5.0),
                    color: Colors.red,
                    child: Text((_selectIndex == 0)
                        ? listGeneraciones[index].name.toString()
                        : listTypes[index].name.toString()),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }

  fillList(String _json) {
    (_selectIndex == 0) ? listGeneraciones.clear() : listTypes.clear();
    var convertJson = jsonDecode(_json) as List;
    List<JsonPokemontype> jsonClass =
        convertJson.map((e) => JsonPokemontype.fromJson(e)).toList();
    jsonClass.forEach((element) {
      if (element.name!.isNotEmpty && element.url!.isNotEmpty) {
        (_selectIndex == 0)
            ? listGeneraciones
                .add(JsonPokemontype(name: element.name, url: element.url))
            : listTypes
                .add(JsonPokemontype(name: element.name, url: element.url));
      }
    });
  }
}
