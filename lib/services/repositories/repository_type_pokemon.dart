import 'package:poke_app/class/type_pokemon.dart';
import 'package:poke_app/services/api.dart';

Api api = Api();

class TypePokemonRepository {
  Future<List<TypePokemon>> getTypePokemon() async {
    dynamic response = await api.get('types/');
    return parseTypePokemon(response.data);
  }
}
