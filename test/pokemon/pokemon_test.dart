import 'package:flutter_test/flutter_test.dart';
import 'package:poke_app/class/pokemon_obj.dart';

void main() {
  group('Pokemon Class test', () {
    test(
      'Pokemon fromJson Method should create a Pokemon object from JSON map',
      () {
        final Map<String, dynamic> jsonData = {
          "url": "https://pokeapi.com/api/pokemon/1/",
          "name": "Bulbasaur",
        };

        final Pokemon pokemon = Pokemon.fromJson(jsonData);

        expect(pokemon.id, 1);
        expect(pokemon.name, "Bulbasaur");
        expect(pokemon.urlDetail, "https://pokeapi.com/api/pokemon/1/");
        expect(pokemon.image,
            "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/1.png");
      },
    );

    test(
      'PokemonDetails fromJson Method should create a pokemon object from Json map',
      () {
        final Map<String, dynamic> pokemonDetailData = {
          'id': 25,
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
              'type': {'name': 'electric'}
            },
          ],
        };

        final PokemonDetails pokemonDetails =
            parsePokemonDetails(pokemonDetailData);

        expect(pokemonDetails.id, 25);
        expect(pokemonDetails.name, 'Pikachu');
        expect(pokemonDetails.weight, 6.0);
        expect(pokemonDetails.height, 0.4);
        expect(pokemonDetails.types, ['electric']);
        expect(pokemonDetails.image,
            'https://pokeapi.co/media/sprites/pokemon/25.png');
        expect(pokemonDetails.imageShiny,
            'https://pokeapi.co/media/sprites/pokemon/shiny/25.png');
      },
    );

    test(
      'Pokemon toString should return the corect string representation',
      () {
        final Pokemon pokemon = Pokemon(
          id: 1,
          name: 'Bulbasaur',
          image: "https://pokeapi.com/api/pokemon/1.png",
          urlDetail: "https://pokeapi.com/api/pokemon/1/",
        );

        expect(
          pokemon.toString(),
          'Pokemon(id: 1, name: Bulbasaur image: https://pokeapi.com/api/pokemon/1.png)',
        );
      },
    );
  });
}
