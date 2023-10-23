import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:poke_app/app/app.dart';
import 'package:poke_app/pages/pokemon/widgets/item_pokemon.dart';
import 'package:poke_app/utils/string_extension.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('end-to-end pokemon', () {
    testWidgets(
      'tap in option menu to navigate list pokemon and show details of first pokemon',
      (tester) async {
        await tester.pumpWidget(const MyApp());

        await tester.pump(const Duration(milliseconds: 3500));
        final circularFind = find.byType(CircularProgressIndicator);
        expect(circularFind, findsOneWidget);

        await tester.pumpAndSettle();

        final itemMenuPokedex = find.byKey(const Key('option_pokedex'));

        expect(find.text('What Pokemon'), findsOneWidget);
        expect(itemMenuPokedex, findsOneWidget);

        await tester.tap(itemMenuPokedex);

        await tester.pumpAndSettle();

        expect(find.text('Pokedex'), findsOneWidget);
        expect(find.byType(ItemPokemon), findsWidgets);

        final firstPokemonItem = find.byKey(const Key('pokemon_0'));

        expect(firstPokemonItem, findsOneWidget);

        final firstPokemon =
            firstPokemonItem.evaluate().first.widget as ItemPokemon;

        await tester.tap(firstPokemonItem);

        await tester.pumpAndSettle();

        expect(
          find.text(firstPokemon.pokemon.name.capitalize()),
          findsOneWidget,
        );
      },
    );
  });
}
