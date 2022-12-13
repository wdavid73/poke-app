import 'package:poke_app/class/pokemon_obj.dart';
import 'package:poke_app/services/api.dart';

Api api = Api();

class PokemonRepository {
  Future<List<Pokemon>> getPokemon() async {
    dynamic response = await api.get('pokemon/');
    return parsePokemon(response.data);
  }
}
