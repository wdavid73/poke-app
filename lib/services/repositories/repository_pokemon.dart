import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:poke_app/class/pokemon_obj.dart';
import 'package:poke_app/services/api.dart';
import 'package:poke_app/services/response.dart';

Api api = Api();

class PokemonRepository {
  Future<List<Pokemon>> getPokemon() async {
    String jsonString = await rootBundle.loadString('assets/pokedex.json');
    List<Pokemon> pokemon = parsePokemon(jsonString);
    return pokemon;
    // Response response = await api.get('pokemon/');
    // return parsePokemon(response.data);
  }

  Future<Response> createPokemon(Map<String, dynamic> pokemon) async {
    dynamic response = await api.post(
      'pokemon/create/',
      pokemon,
      withFile: true,
    );
    return response;
  }

  Future<Response> deletePokemon(int idPokemon) async {
    dynamic response = await api.delete('pokemon/$idPokemon/');
    return response;
  }
}
