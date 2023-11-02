import 'package:dio/dio.dart';
import 'package:poke_app/class/pokemon_obj.dart';
import 'package:poke_app/services/api.dart';
import 'package:poke_app/services/api_endpoint.dart';
import 'package:poke_app/services/repositories/repository_pokemon.dart';
import 'package:poke_app/services/response.dart';

class PokemonRepositoryImpl extends PokemonRepository {
  final ApiClient _client;

  PokemonRepositoryImpl(this._client);

  @override
  Future<ResponseState> getPokemon() async {
    try {
      final response = await _client.get(ApiEndpoint.pokemon);
      List<Pokemon> pokemon = parsePokemon(response.data["results"]);
      return ResponseSuccess({
        "total": response.data["count"] as int,
        "data": pokemon,
      }, response.statusCode!);
    } catch (e) {
      return ResponseFailed(
        DioException(
          error: e,
          requestOptions: RequestOptions(
            path: ApiEndpoint.pokemon,
          ),
        ),
      );
    }
  }

  @override
  Future<ResponseState> getPokemonDetail(int id) async {
    try {
      final response = await _client.get("${ApiEndpoint.pokemon}/$id/");
      final PokemonDetails pokemon = parsePokemonDetails(response.data);
      return ResponseSuccess(pokemon, response.statusCode!);
    } catch (e) {
      return ResponseFailed(
        DioException(
          error: e,
          requestOptions: RequestOptions(
            path: ApiEndpoint.pokemon,
          ),
        ),
      );
    }
  }

  @override
  Future<ResponseState> searchPokemon(String name) async {
    try {
      final response = await _client.get('${ApiEndpoint.pokemon}/$name/');
      final PokemonDetails pokemon = parsePokemonDetails(response.data);
      return ResponseSuccess(pokemon, response.statusCode!);
    } catch (e) {
      return ResponseFailed(
        DioException(
          error: e,
          requestOptions: RequestOptions(
            path: ApiEndpoint.pokemon,
          ),
        ),
      );
    }
  }
}
