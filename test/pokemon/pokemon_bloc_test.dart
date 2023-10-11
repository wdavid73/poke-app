import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:poke_app/bloc/pokemon/pokemon_bloc.dart';
import 'package:poke_app/class/pokemon_obj.dart';
import 'package:poke_app/services/api_endpoint.dart';

import '../mocks/mock_pokemon_bloc.dart';

void main() {
  group('Pokemon Bloc Test', () {
    late MockPokemonBloc pokemonBloc;

    final expectedPokemonList = [
      Pokemon(
        id: 25,
        name: 'Pikachu',
        image: "${ApiEndpoint.pokemonPhoto}/25.png",
        urlDetail: 'https://pokeapi.co/api/v2/pokemon/25/',
      ),
      Pokemon(
        id: 6,
        name: 'Charizard',
        image: "${ApiEndpoint.pokemonPhoto}/6.png",
        urlDetail: 'https://pokeapi.co/api/v2/pokemon/6/',
      ),
    ];

    final expectPokemonDetail = PokemonDetails(
      name: "Bulbasaur",
      image: "${ApiEndpoint.pokemonPhoto}/1.png",
      imageShiny: "${ApiEndpoint.pokemonPhoto}/1.png",
      height: 20,
      weight: 50,
      urlDetail: 'https://pokeapi.co/api/v2/pokemon/1/',
      types: ['grass', 'poison'],
    );

    setUp(() {
      final mockPokemonRepository = MockPokemonRepository();
      final mockPokemonUseCase = MockPokemonUseCase(mockPokemonRepository);
      pokemonBloc = MockPokemonBloc(mockPokemonUseCase);
    });

    tearDown(() => pokemonBloc.close());

    blocTest<MockPokemonBloc, PokemonState>(
      'Emits PokemonState with loaded data',
      build: () => pokemonBloc,
      act: (bloc) => bloc.add(GetPokemon()), // Dispara el evento GetPokemon
      wait: const Duration(milliseconds: 500),
      expect: () => [
        const PokemonState(
          loading: true,
          hasError: false,
          isDone: false,
          pokemon: [],
        ),
        PokemonState(
          loading: false,
          isDone: true,
          hasError: false,
          pokemon: expectedPokemonList,
        ),
      ],
    );

    blocTest<MockPokemonBloc, PokemonState>(
      'Emits PokemonState get pokemon detail',
      build: () => pokemonBloc,
      act: (bloc) => bloc.add(GetPokemonDetail(id: 1)),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        const PokemonState(
          loading: true,
          hasError: false,
          isDone: false,
        ),
        PokemonState(
          loading: false,
          hasError: false,
          isDone: false,
          pokemonDetail: expectPokemonDetail,
        ),
      ],
    );

    blocTest<MockPokemonBloc, PokemonState>(
      'Emits PokemonState to clear state',
      build: () => pokemonBloc,
      act: (bloc) => bloc.add(ClearState()),
      expect: () => [
        equals(
          const PokemonState(
            loading: false,
            pokemon: [],
          ),
        ),
      ],
    );
  });
}
