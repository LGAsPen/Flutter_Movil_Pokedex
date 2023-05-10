// ignore_for_file: file_names

import 'dart:convert';

JsonPokemon jsonPokemontypeFromJson(String str) =>
    JsonPokemon.fromJson(json.decode(str));

String jsonPokemontypeToJson(JsonPokemon data) => json.encode(data.toJson());

class JsonPokemon {
  JsonPokemon({
    this.name,
    this.url,
  });

  String? name;
  String? url;

  factory JsonPokemon.fromJson(Map<String, dynamic> json) => JsonPokemon(
        name: json["name"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "url": url,
      };
}
