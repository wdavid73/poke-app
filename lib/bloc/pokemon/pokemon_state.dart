part of 'pokemon_bloc.dart';

class PokemonState {
  final List<Pokemon> pokemon;
  final List<Pokemon> pokemonFiltered;

  PokemonState({
    this.pokemon = const <Pokemon>[],
    this.pokemonFiltered = const <Pokemon>[],
  });

  PokemonState copyWith({
    List<Pokemon>? pokemon,
    List<Pokemon>? pokemonFiltered,
  }) =>
      PokemonState(
        pokemon: pokemon ?? this.pokemon,
        pokemonFiltered: pokemonFiltered ?? this.pokemonFiltered,
      );
}
