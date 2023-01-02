// ignore_for_file: file_names

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:pokemon_pokedex/src/json/pokemType.dart';

class GetData {
  generationsPokemon() async {
    try {
      Response response =
          await get(Uri.parse('https://pokeapi.co/api/v2/generation'));

      dynamic jsonData = json.decode(response.body);
      dynamic jsonGenerations = json.encode(jsonData['results']);

      if (response.statusCode == 200) {
        return jsonGenerations;
      } else {
        throw Exception('Pokemon type error');
      }
    } catch (e) {
      debugPrint('Pokemon type error');
    }
  }

  imgGenrations(url) async {
    try {
      Response res = await get(Uri.parse('$url'));
      if (res.statusCode == 200) {
        String pokemon = "";
        dynamic jsonResults = json.decode(res.body);
        dynamic jsonNamePokemon = json.encode(jsonResults['pokemon_species']);

        var tagObjsJson = jsonDecode(jsonNamePokemon) as List;
        List<JsonPokemontype> tagObjs = tagObjsJson
            .map((tagJson) => JsonPokemontype.fromJson(tagJson))
            .toList();
        for (var i = 0; i < 1; i++) {
          pokemon = '${tagObjs[0].url}';
        }
        var changeId = pokemon.split('pokemon-species');
        return changeId[1].replaceAll('/', '');
      } else {
        throw Exception('Error post');
      }
    } catch (e) {
      debugPrint('3');
    }
  }

  typesPokemons() async {
    try {
      Response response =
          await get(Uri.parse('https://pokeapi.co/api/v2/type'));

      dynamic jsonData = json.decode(response.body);
      dynamic jsonType = json.encode(jsonData['results']);

      if (response.statusCode == 200) {
        return jsonType;
      } else {
        throw Exception('Pokemon type error');
      }
    } catch (e) {
      debugPrint('Pokemon type error');
    }
  }

  pokemonData(String url) async {
    try {
      Response response = await get(Uri.parse(url));
      dynamic jsonData = json.decode(response.body);
      dynamic jsonPokemonData = json.encode(jsonData['pokemon_species']);
      if (response.statusCode == 200) {
        return jsonPokemonData;
      } else {
        throw Exception('Pokemon data error');
      }
    } catch (e) {
      debugPrint('Pokemon data error');
    }
  }
}
