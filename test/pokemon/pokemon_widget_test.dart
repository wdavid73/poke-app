import 'package:bloc_test/bloc_test.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:poke_app/bloc/pokemon/pokemon_bloc.dart';
import 'package:poke_app/class/pokemon_obj.dart';
import 'package:poke_app/pages/pokemon/list_pokemon.dart';
import 'package:poke_app/pages/pokemon/widgets/item_pokemon.dart';
import 'package:poke_app/services/api_endpoint.dart';
import 'package:poke_app/utils/routes.dart';

class MockPokemonBloc extends MockBloc<PokemonEvent, PokemonState>
    implements PokemonBloc {}

class PokemonStateFake extends Fake implements PokemonState {}

class PokemonEventFake extends Fake implements PokemonEvent {}

void main() {
  group('ListPokemon Widget', () {
    final mockPokemonData = [
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

    testWidgets('Load successful data', (WidgetTester tester) async {
      final mockPokemonBloc = MockPokemonBloc();
      when(() => mockPokemonBloc.state).thenAnswer(
        (_) => PokemonState(
          isDone: true,
          hasError: false,
          loading: false,
          pokemon: mockPokemonData,
        ),
      );

      await tester.pumpWidget(
        BlocProvider<PokemonBloc>(
          create: (context) => mockPokemonBloc,
          child: const MaterialApp(
            home: ListPokemon(),
          ),
        ),
      );

      expect(find.byType(ItemPokemon), findsWidgets);
    });

    testWidgets('Test error handling', (WidgetTester tester) async {
      final mockPokemonBloc = MockPokemonBloc();
      when(() => mockPokemonBloc.state).thenAnswer(
        (_) => const PokemonState(
          isDone: false,
          hasError: true,
          loading: false,
          pokemon: [],
          errorMessage: 'Error Testing',
        ),
      );

      await tester.pumpWidget(
        BlocProvider<PokemonBloc>(
          create: (context) => mockPokemonBloc,
          child: const MaterialApp(
            home: ListPokemon(),
          ),
        ),
      );

      expect(find.text('Error Testing'), findsOneWidget);
    });

    testWidgets('Test data refresh on pull down', (WidgetTester tester) async {
      final mockPokemonBloc = MockPokemonBloc();
      when(() => mockPokemonBloc.state).thenAnswer(
        (_) => PokemonState(
          isDone: true,
          hasError: false,
          loading: false,
          pokemon: mockPokemonData,
        ),
      );
      await tester.pumpWidget(
        BlocProvider<PokemonBloc>(
          create: (context) => mockPokemonBloc,
          child: const MaterialApp(
            home: ListPokemon(),
          ),
        ),
      );
      expect(find.byType(RefreshIndicator), findsOneWidget);

      await tester.drag(
        find.byType(RefreshIndicator),
        const Offset(0.0, 100),
      );

      await tester.pump(const Duration(seconds: 1));
      expect(find.byType(ItemPokemon), findsWidgets);
    });

    /*testWidgets('Test navigation when pressing back button',
        (WidgetTester tester) async {
      final mockPokemonBloc = MockPokemonBloc();
      when(() => mockPokemonBloc.state).thenAnswer(
        (_) => PokemonState(isDone: true, pokemon: mockPokemonData),
      );

      await tester.pumpWidget(
        BlocProvider<PokemonBloc>(
          create: (_) => mockPokemonBloc,
          child: const MaterialApp(
            home: ListPokemon(),
          ),
        ),
      );
      // Simula el tap en el botón de retroceso
      await tester.tap(find.byIcon(Icons.arrow_back));

      // Espera a que la navegación se complete
      await tester.pumpAndSettle();

      // Realiza tus aserciones de que se ha navegado correctamente
    });*/

    testWidgets('Test "No data" message when no data available',
        (WidgetTester tester) async {
      final mockPokemonBloc = MockPokemonBloc();
      when(() => mockPokemonBloc.state).thenAnswer(
        (_) => const PokemonState(), // Estado vacío, sin datos
      );

      await tester.pumpWidget(
        BlocProvider<PokemonBloc>(
          create: (_) => mockPokemonBloc,
          child: const MaterialApp(
            home: ListPokemon(),
          ),
        ),
      );
      // Asegura que se muestra el mensaje "no data"
      expect(find.text('no data'), findsOneWidget);
    });
  });

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