import 'package:poke_app/services/repositories/repository_pokemon.dart';
import 'package:poke_app/services/response.dart';

abstract class BasePokemonUseCase {
  Future<ResponseState> getPokemon();
  Future<ResponseState> getPokemonDetail(int id);
  Future<ResponseState> searchPokemon(String name);
}

class PokemonUseCase implements BasePokemonUseCase {
  final PokemonRepository _repository;

  PokemonUseCase(this._repository);

  @override
  Future<ResponseState> getPokemon() async {
    final response = await _repository.getPokemon();
    return response;
  }

  @override
  Future<ResponseState> getPokemonDetail(int id) async {
    final response = await _repository.getPokemonDetail(id);
    return response;
  }

  @override
  Future<ResponseState> searchPokemon(String name) async {
    final response = await _repository.searchPokemon(name);
    return response;
  }
}
