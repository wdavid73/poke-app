part of 'pokemon_bloc.dart';

class PokemonState {
  final List<Pokemon> pokemon;
  final bool loading;
  final bool isDone;
  final bool hasError;
  final Map<String, dynamic> params;
  final int total;
  final String errorMessage;
  final PokemonDetails? pokemonDetail;

  PokemonState({
    this.pokemon = const <Pokemon>[],
    this.loading = false,
    this.isDone = false,
    this.hasError = false,
    this.total = 0,
    this.errorMessage = '',
    this.params = const {
      "offset": 20,
      "limit": 20,
    },
    this.pokemonDetail,
  });

  PokemonState copyWith({
    List<Pokemon>? pokemon,
    bool? loading,
    bool? isDone,
    bool? hasError,
    Map<String, dynamic>? params,
    int? total,
    String? errorMessage,
    PokemonDetails? pokemonDetail,
  }) =>
      PokemonState(
        pokemon: pokemon ?? this.pokemon,
        loading: loading ?? this.loading,
        total: total ?? this.total,
        params: params ?? this.params,
        isDone: isDone ?? this.isDone,
        hasError: hasError ?? this.hasError,
        errorMessage: errorMessage ?? this.errorMessage,
        pokemonDetail: pokemonDetail ?? this.pokemonDetail,
      );

  @override
  String toString() {
    return ""
        "PokemonState: ${pokemon.length},\n"
        "loading: $loading,\n"
        "isDone: $isDone,\n"
        "hasError: $hasError,\n"
        "";
  }
}
