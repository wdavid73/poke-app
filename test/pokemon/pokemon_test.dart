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
