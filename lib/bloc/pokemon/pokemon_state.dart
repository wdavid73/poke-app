part of 'pokemon_bloc.dart';

class PokemonState extends Equatable {
  final List<Pokemon> pokemon;
  final bool loading;
  final bool loadingSearch;
  final bool isDone;
  final bool hasError;
  final bool findPokemon;
  final Map<String, dynamic> params;
  final int total;
  final String errorMessage;
  final PokemonDetails? pokemonDetail;

  const PokemonState({
    this.pokemon = const <Pokemon>[],
    this.loading = false,
    this.loadingSearch = false,
    this.isDone = false,
    this.hasError = false,
    this.findPokemon = false,
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
    bool? loadingSearch,
    bool? findPokemon,
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
        loadingSearch: loadingSearch ?? this.loadingSearch,
        findPokemon: findPokemon ?? this.findPokemon,
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

  @override
  List<Object?> get props => [loading, isDone, hasError, loadingSearch];
}
