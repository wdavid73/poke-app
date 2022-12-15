import 'package:poke_app/class/pokemon_obj.dart';
import 'package:poke_app/services/api.dart';
import 'package:poke_app/services/response.dart';

Api api = Api();

class PokemonRepository {
  Future<List<Pokemon>> getPokemon() async {
    dynamic response = await api.get('pokemon/');
    return parsePokemon(response.data);
  }

  Future<Response> createPokemon(Map<String, dynamic> pokemon) async {
    dynamic response = await api.post(
      'pokemon/create/',
      pokemon,
      withFile: true,
    );
    return response;
  }
}
