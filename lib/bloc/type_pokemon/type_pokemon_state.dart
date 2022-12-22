part of 'type_pokemon_bloc.dart';

class TypePokemonState {
  final List<TypePokemon> typePokemon;
  final bool loading;
  final bool isDone;
  final bool hasError;

  TypePokemonState({
    this.typePokemon = const <TypePokemon>[],
    this.loading = false,
    this.isDone = false,
    this.hasError = false,
  });

  TypePokemonState copyWith({
    List<TypePokemon>? typePokemon,
    bool? loading,
    bool? isDone,
    bool? hasError,
  }) =>
      TypePokemonState(
        typePokemon: typePokemon ?? this.typePokemon,
        loading: loading ?? this.loading,
        isDone: isDone ?? this.isDone,
        hasError: hasError ?? this.hasError,
      );

  @override
  String toString() {
    return "TypePokemonState: $typePokemon,\n"
        "isDone: $isDone, \n"
        "hasError: $hasError, \n"
        "loading: $loading, \n"
    ;
  }
}
