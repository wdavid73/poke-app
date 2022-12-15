part of 'type_pokemon_bloc.dart';

class TypePokemonState {
  final List<TypePokemon> typePokemon;
  final bool loading;

  TypePokemonState({
    this.typePokemon = const <TypePokemon>[],
    this.loading = false,
  });

  TypePokemonState copyWith({
    List<TypePokemon>? typePokemon,
    bool? loading,
  }) =>
      TypePokemonState(
        typePokemon: typePokemon ?? this.typePokemon,
        loading: loading ?? this.loading,
      );
}
