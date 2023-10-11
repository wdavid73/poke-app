import 'package:dio/dio.dart';
import 'package:poke_app/bloc/pokemon/pokemon_bloc.dart';
import 'package:poke_app/class/pokemon_obj.dart';
import 'package:poke_app/services/api_endpoint.dart';
import 'package:poke_app/services/repositories/repository_pokemon.dart';
import 'package:poke_app/services/response.dart';
import 'package:poke_app/services/usecases/pokemon_usecase.dart';

class MockPokemonRepository extends PokemonRepository {
  @override
  Future<ResponseState> getPokemon() async {
    try {
      final List<dynamic> pokemonData = [
        {
          'name': 'Pikachu',
          'url': 'https://pokeapi.co/api/v2/pokemon/25/',
        },
        {
          'name': 'Charizard',
          'url': 'https://pokeapi.co/api/v2/pokemon/6/',
        },
        // Agrega más datos ficticios de Pokémon según tus necesidades
      ];

      final List<Pokemon> pokemonList = parsePokemon(pokemonData);

      return ResponseSuccess({
        'total': pokemonList.length,
        'data': pokemonList,
      }, 200); // Simulamos un código de estado HTTP 200 (éxito)
    } catch (e) {
      return ResponseFailed(DioException(
        error: e,
        requestOptions: RequestOptions(path: ApiEndpoint.pokemon),
      ));
    }
  }

  @override
  Future<ResponseState> getPokemonDetail(int id) async {
    try {
      // Simulamos una respuesta exitosa con datos ficticios para un Pokémon específico
      final Map<String, dynamic> pokemonDetailData = {
        'name': 'Pikachu',
        'weight': 6.0,
        'height': 0.4,
        'sprites': {
          'other': {
            'official-artwork': {
              'front_default':
                  'https://pokeapi.co/media/sprites/pokemon/25.png',
              'front_shiny':
                  'https://pokeapi.co/media/sprites/pokemon/shiny/25.png',
            },
          },
        },
        'types': [
          {
            'type': {'name': 'Electric'}
          },
        ],
      };

      final PokemonDetails pokemonDetail =
          parsePokemonDetails(pokemonDetailData);

      return ResponseSuccess(
          pokemonDetail, 200); // Simulamos un código de estado HTTP 200 (éxito)
    } catch (e) {
      // En caso de error, simulamos una respuesta de error
      return ResponseFailed(DioException(
        error: 'Error simulado',
        requestOptions: RequestOptions(
          path: ApiEndpoint.pokemon,
        ),
      ));
    }
  }
}

class MockPokemonUseCase implements BasePokemonUseCase {
  final MockPokemonRepository _repository;
  MockPokemonUseCase(this._repository);

  @override
  Future<ResponseState> getPokemon() async {
    return _repository.getPokemon();
  }

  @override
  Future<ResponseState> getPokemonDetail(int id) async {
    return _repository.getPokemonDetail(id);
  }
}

class MockPokemonBloc extends PokemonBloc {
  final MockPokemonUseCase pokemonUseCase;
  MockPokemonBloc(this.pokemonUseCase) : super(pokemonUseCase);
}
