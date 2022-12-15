import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:poke_app/class/pokemon_obj.dart';
import 'package:poke_app/services/repositories/repository_pokemon.dart';

part 'pokemon_event.dart';
part 'pokemon_state.dart';

class PokemonBloc extends Bloc<PokemonEvent, PokemonState> {
  final PokemonRepository _pokemonRepository = PokemonRepository();

  PokemonBloc() : super(PokemonState()) {
    on<PokemonEvent>(
      (event, emit) async {
        // event get pokemon
        if (event is GetPokemon) {
          emit.call(await _getPokemon());
        }

        // event reduce list pokemon
        if (event is ReduceListPokemon) {
          emit.call(
            state.copyWith(
              pokemon: state.pokemon.sublist(state.pokemon.length - 2),
            ),
          );
        }

        // event find pokemon
        if (event is FindPokemon) {
          emit.call(_findPokemon(event.name));
        }

        // event create pokemon
        if (event is CreatePokemonEvent) {
          emit.call(_setLoading(true));
          // PokemonState response = await _createPokemon(event.pokemon);
          emit.call(await _createPokemon(event.pokemon));
          emit.call(_setLoading(false));
        }

        if (event is SetLoading) {
          emit.call(_setLoading(event.loading));
        }

        if (event is ResetStateCreatedPokemon) {
          emit.call(state.copyWith(pokemonCreated: false));
        }
      },
    );
  }

  Future<PokemonState> _getPokemon() async {
    dynamic data = await _pokemonRepository.getPokemon();
    List<Pokemon> pokemon = data;
    return state.copyWith(pokemon: pokemon);
  }

  PokemonState _findPokemon(String name) {
    List<Pokemon> pokemon = state.pokemon;
    List<Pokemon> pokemonFiltered = <Pokemon>[];
    if (name != '') {
      for (var element in pokemon) {
        if (element.name == name) {
          pokemonFiltered.add(element);
        }
      }
    }
    return state.copyWith(pokemonFiltered: pokemonFiltered);
  }

  Future<PokemonState> _createPokemon(PokemonFile pokemon) async {
    var response = await _pokemonRepository.createPokemon(pokemon.toJson());
    return state.copyWith(pokemonCreated: response.status);
  }

  PokemonState _setLoading(bool loading) {
    return state.copyWith(loading: loading);
  }
}
