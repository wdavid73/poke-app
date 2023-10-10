import 'package:poke_app/services/repositories/repository_pokemon.dart';
import 'package:poke_app/services/response.dart';

class PokemonUseCase {
  final PokemonRepository _repository;

  PokemonUseCase(this._repository);

  Future<ResponseState> getPokemon() async {
    final response = await _repository.getPokemon();
    return response;
  }

  Future<ResponseState> getPokemonDetail(int id) async {
    final response = await _repository.getPokemonDetail(id);
    return response;
  }
}
