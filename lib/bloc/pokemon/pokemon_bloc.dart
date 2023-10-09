import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poke_app/class/pokemon_obj.dart';
import 'package:poke_app/services/response.dart';
import 'package:poke_app/services/usecases/pokemon_usecase.dart';

part 'pokemon_event.dart';
part 'pokemon_state.dart';

class PokemonBloc extends Bloc<PokemonEvent, PokemonState> {
  final PokemonUseCase _pokemonUseCase;

  PokemonBloc(this._pokemonUseCase) : super(PokemonState()) {
    const Duration duration = Duration(milliseconds: 500);
    on<PokemonEvent>(
      (event, emit) async {
        // event get pokemon
        if (event is GetPokemon) {
          emit.call(state.copyWith(
            loading: true,
            hasError: false,
            isDone: false,
          ));
          await Future.delayed(duration);
          emit.call(await _getPokemon());
          emit.call(state.copyWith(loading: false));
        }

        if (event is ClearState) {
          emit.call(state.copyWith(
            pokemon: [],
            loading: false,
          ));
        }
      },
    );
  }

  Future<PokemonState> _getPokemon() async {
    ResponseState response = await _pokemonUseCase.getPokemon();
    if (response is ResponseFailed) {
      return state.copyWith(
        pokemon: [],
        loading: false,
        isDone: false,
        hasError: true,
      );
    }
    return state.copyWith(
      loading: false,
      isDone: true,
      hasError: false,
    );
  }
}
