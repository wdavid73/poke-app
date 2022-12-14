part of 'pokemon_bloc.dart';

class PokemonState {
  final List<Pokemon> pokemon;
  final List<Pokemon> pokemonFiltered;
  final bool loading;
  final bool pokemonCreated;

  PokemonState({
    this.pokemon = const <Pokemon>[],
    this.pokemonFiltered = const <Pokemon>[],
    this.loading = false,
    this.pokemonCreated = false,
  });

  PokemonState copyWith({
    List<Pokemon>? pokemon,
    List<Pokemon>? pokemonFiltered,
    bool? loading,
    bool? pokemonCreated,
  }) =>
      PokemonState(
        pokemon: pokemon ?? this.pokemon,
        pokemonFiltered: pokemonFiltered ?? this.pokemonFiltered,
        loading: loading ?? this.loading,
        pokemonCreated: pokemonCreated ?? this.pokemonCreated,
      );
}
