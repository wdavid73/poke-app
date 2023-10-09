import 'package:dio/dio.dart';
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
      print(response);
      return ResponseSuccess(null, response.statusCode!);
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
