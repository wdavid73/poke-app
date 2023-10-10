import 'dart:io';
import 'package:poke_app/services/api_endpoint.dart';

class Pokemon {
  int? id;
  String name;
  String image;
  String? urlDetail;

  Pokemon({
    this.id,
    required this.image,
    required this.name,
    this.urlDetail,
  });

  @override
  String toString() {
    return 'Pokemon(id: $id, name: $name image: $image)';
  }

  factory Pokemon.fromJson(Map<String, dynamic> data) {
    return Pokemon(
      id: getPokemonIdFromUrl(data["url"]),
      name: data['name'] as String,
      image:
          "${ApiEndpoint.pokemonPhoto}/${getPokemonIdFromUrl(data["url"])}.png",
      urlDetail: data['url'] as String?,
    );
  }
}

List<Pokemon> parsePokemon(List<dynamic> data) {
  return data.map<Pokemon>((json) => Pokemon.fromJson(json)).toList();
}

int getPokemonIdFromUrl(String url) {
  List<String> parts = url.split("/");
  parts.removeWhere((element) => element.isEmpty);
  String lastItem = parts.last;
  int idPokemon = int.parse(lastItem);
  return idPokemon;
}

class PokemonFile extends Pokemon {
  File? photo;
  List<String> typeId;

  PokemonFile({
    super.image = '',
    required super.name,
    required this.photo,
    required this.typeId,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["name"] = name;
    data["image"] = photo;
    data['type_id'] = typeId;
    return data;
  }

  @override
  String toString() {
    return 'PokemonFile(name: $name image: $photo, type: $typeId)';
  }
}

class PokemonDetails extends Pokemon {
  double weight;
  double height;
  String imageShiny;
  List<String> types;

  PokemonDetails({
    required super.image,
    required super.name,
    required this.weight,
    required this.height,
    required this.types,
    required this.imageShiny,
  });
}

PokemonDetails parsePokemonDetails(dynamic pokemon) {
  List<String> types = [];
  for (var type in pokemon["types"]) {
    if (type.containsKey("type") && type["type"].containsKey("name")) {
      types.add(type["type"]["name"]);
    }
  }
  return PokemonDetails(
    image: pokemon["sprites"]["other"]["official-artwork"]["front_default"],
    imageShiny: pokemon["sprites"]["other"]["official-artwork"]["front_shiny"],
    name: pokemon["name"],
    weight: double.parse(pokemon["weight"].toString()),
    height: double.parse(pokemon["height"].toString()),
    types: types,
  );
}
