/* import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:poke_app/bloc/pokemon/pokemon_bloc.dart';
import 'package:poke_app/class/pokemon_obj.dart';
import 'package:poke_app/pages/pokemon/widgets/item_pokemon.dart';

import '../mocks/mock_pokemon_bloc.dart';

void main() {
  group('Pokemon Test', () {
    late MockPokemonBloc pokemonBloc;

    setUp(() {
      final mockPokemonRepository = MockPokemonRepository();
      final mockPokemonUseCase = MockPokemonUseCase(mockPokemonRepository);
      pokemonBloc = MockPokemonBloc(mockPokemonUseCase);
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

        await tester.runAsync(() async {
          await tester.pumpWidget(
            BlocProvider<PokemonBloc>(
              create: (context) => pokemonBloc,
              child: MaterialApp(
                home: ItemPokemon(
                  pokemon: testPokemon,
                ),
              ),
            ),
          );
        });

        final namePokemon = find.text('Bulbasaur');
        final gestureFinder = find.byType(GestureDetector);

        expect(namePokemon, findsOneWidget);
        expect(gestureFinder, findsOneWidget);
        /** FALLO EN EL TEST */
        await tester.runAsync(() => tester.tap(find.byType(GestureDetector)));
        /* await tester.pumpAndSettle(

        ); */
        expect(find.byType(CircularProgressIndicator), findsOneWidget);

        /* await tester.tap(gestureFinder);
        await tester.pumpAndSettle(kThemeAnimationDuration);
        expect(find.byType(CircularProgressIndicator), findsOneWidget); */
      },
    );
  });
} */

import 'package:bloc_test/bloc_test.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:poke_app/bloc/pokemon/pokemon_bloc.dart';
import 'package:poke_app/class/pokemon_obj.dart';
import 'package:poke_app/pages/pokemon/widgets/item_pokemon.dart';
import 'package:poke_app/utils/routes.dart';

class MockPokemonBloc extends MockBloc<PokemonEvent, PokemonState>
    implements PokemonBloc {}

class PokemonStateFake extends Fake implements PokemonState {}

class PokemonEventFake extends Fake implements PokemonEvent {}

void main() {
  group('ItemPokemon Widget', () {
    setUpAll(() {
      registerFallbackValue(PokemonStateFake());
      registerFallbackValue(PokemonEventFake());
    });

    testWidgets(
      'ItemPokemon should show a name and image of pokemon',
      (tester) async {
        final mockPokemonBloc = MockPokemonBloc();
        when(() => mockPokemonBloc.state).thenReturn(
          const PokemonState(),
        );

        final navigatorKey = GlobalKey<NavigatorState>();

        final Pokemon testPokemon = Pokemon(
          id: 1,
          name: 'Bulbasaur',
          image: "https://pokeapi.com/api/pokemon/1.png",
          urlDetail: "https://pokeapi.com/api/pokemon/1/",
        );
        final widget = BlocProvider<PokemonBloc>(
          create: (context) => mockPokemonBloc,
          child: MaterialApp(
            navigatorKey: navigatorKey,
            routes: routes,
            home: ItemPokemon(pokemon: testPokemon),
          ),
        );

        await tester.pumpWidget(widget);

        final namePokemon = find.text('Bulbasaur');
        final gestureFinder = find.byType(GestureDetector);
        final imageFinder = find.byType(ExtendedImage);

        expect(namePokemon, findsOneWidget);
        expect(gestureFinder, findsOneWidget);
        expect(imageFinder, findsOneWidget);
      },
    );
  });
}
