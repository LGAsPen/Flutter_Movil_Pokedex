// ignore_for_file: file_names

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pokemon_pokedex/src/api/getData.dart';
import 'package:pokemon_pokedex/src/json/pokemType.dart';

// ignore: must_be_immutable
class HomepokemonGrid extends StatefulWidget {
  String url;
  HomepokemonGrid({Key? key, required this.url}) : super(key: key);
  @override
  State<HomepokemonGrid> createState() => _HomepokemonGridState();
}

class _HomepokemonGridState extends State<HomepokemonGrid> {
  List<JsonPokemon> pokemonData = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Stack(
        children: [pokemonGridView()],
      ),
    );
  }

  Widget pokemonGridView() {
    return FutureBuilder(
        future: GetData().pokemonData(widget.url),
        builder: (context, AsyncSnapshot? snapshot) {
          if (!snapshot!.hasData) {
            return const Center(child: CircularProgressIndicator());
          } else {
            listPokemons(snapshot.data.toString());
            return SafeArea(
              child: GridView.builder(
                  itemCount: pokemonData.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3),
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.all(2.0),
                      // color: Colors.blueAccent,
                      child: Column(
                        children: [
                          Image.network(
                            'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/home/${changeId('${pokemonData[index].url}')}.png',
                            height: 60.0,
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) return child;
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            },
                          ),
                          Text('${pokemonData[index].name} '),
                        ],
                      ),
                    );
                  }),
            );
          }
        });
  }

  listPokemons(String json) {
    pokemonData = [];
    var convertJson = jsonDecode(json) as List;

    List<JsonPokemon> jsonClass =
        convertJson.map((e) => JsonPokemon.fromJson(e)).toList();

    for (var element in jsonClass) {
      pokemonData.add(JsonPokemon(name: element.name, url: element.url));
    }
  }

  changeId(String url) {
    var splitUrl = url.split('pokemon-species');
    String pokemonID = splitUrl[1].replaceAll('/', '');
    return pokemonID;
  }
}
// GridView.builder(
//         itemCount: pokemon.length,
//         gridDelegate:
//             const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
//         itemBuilder: (context, index) {
//           return Text('${pokemon[index]}');
//         },
//       ),
