part of 'pokemon_bloc.dart';

class PokemonState {
  final List<Pokemon> pokemon;
  final List<Pokemon> pokemonFiltered;
  final bool loading;
  final bool pokemonCreated;
  final bool pokemonDeleted;
  final Pokemon? pokemonSelected;

  PokemonState({
    this.pokemon = const <Pokemon>[],
    this.pokemonFiltered = const <Pokemon>[],
    this.loading = false,
    this.pokemonCreated = false,
    this.pokemonSelected,
    this.pokemonDeleted = false,
  });

  PokemonState copyWith({
    List<Pokemon>? pokemon,
    List<Pokemon>? pokemonFiltered,
    bool? loading,
    bool? pokemonCreated,
    Pokemon? pokemonSelected,
    bool? pokemonDeleted,
  }) =>
      PokemonState(
        pokemon: pokemon ?? this.pokemon,
        pokemonFiltered: pokemonFiltered ?? this.pokemonFiltered,
        loading: loading ?? this.loading,
        pokemonCreated: pokemonCreated ?? this.pokemonCreated,
        pokemonSelected: pokemonSelected ?? this.pokemonSelected,
        pokemonDeleted: pokemonDeleted ?? this.pokemonDeleted,
      );

  @override
  String toString() {
    return ""
        "PokemonState: ${pokemon.length},\n"
        "pokemonCreated : $pokemonCreated,\n"
        "loading: $loading,\n"
        "pokemonSelected: $pokemonSelected\n"
        "";
  }
}
