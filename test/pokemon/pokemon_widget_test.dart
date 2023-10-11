import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:poke_app/bloc/pokemon/pokemon_bloc.dart';
import 'package:poke_app/class/pokemon_obj.dart';
import 'package:poke_app/pages/pokemon/widgets/item_pokemon.dart';

import '../mocks/mock_pokemon_bloc.dart';

void main() {
  group('Pokemon Test', () {
    late PokemonBloc pokemonBloc;

    setUp(() {
      final mockPokemonRepository = MockPokemonRepository();
      final mockPokemonUseCase = MockPokemonUseCase(mockPokemonRepository);
      pokemonBloc = PokemonBloc(mockPokemonUseCase);
    });

    tearDown(() => pokemonBloc.close());

    testWidgets(
      'ItemPokemon should show a name and image of pokemon',
      (tester) async {
        final Pokemon testPokemon = Pokemon(
          id: 1,
          name: 'Bulbasaur',
          image: "https://pokeapi.com/api/pokemon/1.png",
          urlDetail: "https://pokeapi.com/api/pokemon/1/",
        );

        await tester.pumpWidget(
          MaterialApp(
            home: BlocProvider<PokemonBloc>(
              create: (_) => pokemonBloc,
              child: ItemPokemon(pokemon: testPokemon),
            ),
          ),
        );

        final namePokemon = find.text('Bulbasaur');
        final gestureFinder = find.byType(GestureDetector);

        expect(namePokemon, findsOneWidget);
        expect(gestureFinder, findsOneWidget);

        await tester.tap(gestureFinder);
        await tester.pumpAndSettle();
      },
    );
  });
}

/*  */
