import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
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
          emit.call(_setLoading(true));
          await Future.delayed(const Duration(milliseconds: 1000));
          emit.call(await _getPokemon());
          emit.call(_setLoading(false));
        }

        // event get pokemon
        if (event is GetPokemonRefresh) {
          await Future<void>.delayed(const Duration(seconds: 3));
          emit.call(_setLoading(true));
          emit.call(await _getPokemon());
          emit.call(_setLoading(false));
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

        if (event is SetPokemon) {
          emit.call(state.copyWith(pokemonSelected: event.pokemon));
        }

        if (event is DeletePokemon) {
          emit.call(await _deletePokemon(event.idPokemon));
        }

        if (event is ClearState) {
          emit.call(state.copyWith(
            pokemonDeleted: false,
            pokemonCreated: false,
            loading: false,
          ));
        }
      },
    );
  }

  Future<PokemonState> _getPokemon() async {
    /* try { */
    dynamic data = await _pokemonRepository.getPokemon();
    List<Pokemon> pokemon = data;
    print(data);
    return state.copyWith(
      pokemon: pokemon,
      isDone: true,
      hasError: false,
    );
    /* } catch (e) {
      print(e);
      return state.copyWith(
        pokemon: <Pokemon>[],
        isDone: false,
        hasError: true,
      );
    } */
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

  Future<PokemonState> _deletePokemon(int idPokemon) async {
    dynamic data = await _pokemonRepository.deletePokemon(idPokemon);
    Pokemon pokemonDeleted = state.pokemon.firstWhere(
      (element) => element.id == idPokemon,
    );
    state.pokemon.remove(pokemonDeleted);
    return state.copyWith(pokemon: state.pokemon, pokemonDeleted: true);
  }
}
