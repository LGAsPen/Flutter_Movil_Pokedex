// ignore_for_file: prefer_is_empty, avoid_function_literals_in_foreach_calls

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

  int _selectIndex = 0;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      bottomNavigationBar: _bottomNavigationBar(),
      body: Stack(
        children: [
          Container(
            color: Colors.black12,
            width: double.infinity,
            alignment: Alignment.topCenter,
            child: Image.asset(
              'assets/icons/snorlax.png',
              width: size.width * 0.4,
              height: size.height * 0.4,
            ),
          ),
          (_selectIndex != 2) ? pokemonFinder() : Container(),
        ],
      ),
    );
  }

  Widget _bottomNavigationBar() {
    return BottomNavigationBar(
      backgroundColor: const Color.fromARGB(220, 10, 162, 238),
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
        height: size.height * 0.22,
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
                    width: size.width * 0.30,
                    margin: const EdgeInsets.all(9.0),
                    decoration: _widgets.decorationCard,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        (_selectIndex == 0)
                            ? FutureBuilder(
                                future: GetData()
                                    .imgGenrations(listGeneraciones[index].url),
                                builder: (context, snapshot) {
                                  if (!snapshot.hasData) {
                                    return const Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  } else {
                                    return Image.network(
                                      'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/${snapshot.data}.png',
                                      height: size.height * 0.10,
                                      loadingBuilder:
                                          (context, child, loadingProgress) {
                                        if (loadingProgress == null) {
                                          return child;
                                        }
                                        return const Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      },
                                    );
                                  }
                                },
                              )
                            : Container(),
                        Text((_selectIndex == 0)
                            ? listGeneraciones[index].name.toString()
                            : listTypes[index].name.toString()),
                      ],
                    ),
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
