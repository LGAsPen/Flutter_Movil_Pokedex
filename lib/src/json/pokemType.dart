// ignore_for_file: file_names

import 'dart:convert';

JsonPokemontype jsonPokemontypeFromJson(String str) =>
    JsonPokemontype.fromJson(json.decode(str));

String jsonPokemontypeToJson(JsonPokemontype data) =>
    json.encode(data.toJson());

class JsonPokemontype {
  JsonPokemontype({
    this.name,
    this.url,
  });

  String? name;
  String? url;

  factory JsonPokemontype.fromJson(Map<String, dynamic> json) =>
      JsonPokemontype(
        name: json["name"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "url": url,
      };
}
