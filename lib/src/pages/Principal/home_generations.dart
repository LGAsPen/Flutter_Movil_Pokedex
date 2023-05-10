import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pokemon_pokedex/provider/provider_selection.dart';
import 'package:pokemon_pokedex/src/api/getData.dart';
import 'package:pokemon_pokedex/src/json/pokemType.dart';
import 'package:provider/provider.dart';

class HomeGenerations extends StatefulWidget {
  const HomeGenerations({Key? key}) : super(key: key);

  @override
  State<HomeGenerations> createState() => _HomeGenerationsState();
}

class _HomeGenerationsState extends State<HomeGenerations> {
  List<JsonPokemon> pokemonData = [];
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final ProviderSelection _providerSelection =
        context.watch<ProviderSelection>();
    return Container(
      // margin: EdgeInsets.only(top: size.height * 0.1),
      height: size.height * 0.55,
      child: pokemonGridView(
          _providerSelection.generation, _providerSelection.nFila),
    );
  }

  Widget pokemonGridView(String nGeneration, int nFila) {
    return FutureBuilder(
        future: GetData()
            .pokemonData('https://pokeapi.co/api/v2/generation/$nGeneration/'),
        builder: (context, AsyncSnapshot? snapshot) {
          if (!snapshot!.hasData) {
            return const Center(child: CircularProgressIndicator());
          } else {
            debugPrint('DATOS::::: ${snapshot.data}');
            if (snapshot.data != null && snapshot.data != "null") {
              var convertJson = jsonDecode(snapshot.data.toString()) as List;
              List<JsonPokemon> jsonClass =
                  convertJson.map((e) => JsonPokemon.fromJson(e)).toList();

              return GridView.builder(
                  itemCount: jsonClass.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: nFila),
                  itemBuilder: (context, index) {
                    return Container(
                      alignment: Alignment.center,
                      margin: const EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                          gradient: LinearGradient(colors: <Color>[
                        const Color.fromARGB(251, 193, 206, 212),
                        Colors.white.withOpacity(0.5),
                      ], begin: Alignment.topLeft, end: Alignment.bottomRight)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.network(
                            'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/home/${changeId('${jsonClass[index].url}')}.png',
                            height: 60.0,
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) return child;
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            },
                          ),
                          Text('${jsonClass[index].name} '),
                        ],
                      ),
                    );
                  });
            } else {
              return Container();
            }
          }
        });
  }

  changeId(String url) {
    var splitUrl = url.split('pokemon-species');
    String pokemonID = splitUrl[1].replaceAll('/', '');
    return pokemonID;
  }
}
