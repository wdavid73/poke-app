import 'package:poke_app/services/response.dart';

abstract class PokemonRepository {
  Future<ResponseState> getPokemon();
  Future<ResponseState> getPokemonDetail(int id);
  Future<ResponseState> searchPokemon(String name);
}
