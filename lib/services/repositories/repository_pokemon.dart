import 'package:poke_app/services/response.dart';

abstract class PokemonRepository {
  Future<ResponseState> getPokemon();
}
