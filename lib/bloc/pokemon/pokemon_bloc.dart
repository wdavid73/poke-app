import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poke_app/class/pokemon_obj.dart';
import 'package:poke_app/services/response.dart';
import 'package:poke_app/services/usecases/pokemon_usecase.dart';

part 'pokemon_event.dart';
part 'pokemon_state.dart';

class PokemonBloc extends Bloc<PokemonEvent, PokemonState> {
  final PokemonUseCase _pokemonUseCase;

  PokemonBloc(this._pokemonUseCase) : super(const PokemonState()) {
    const Duration duration = Duration(milliseconds: 500);
    on<GetPokemon>((event, emit) async {
      emit.call(state.copyWith(
        loading: true,
        hasError: false,
        isDone: false,
        pokemon: [],
      ));
      await Future.delayed(duration);
      emit.call(await _getPokemon());
    });

    // event get pokemon detail
    on<GetPokemonDetail>((event, emit) async {
      emit.call(state.copyWith(loading: true));
      await Future.delayed(duration);
      emit.call(await _getPokemonDetail(event.id));
    });

    // event to search a pokemon
    on<SearchPokemonEvent>((event, emit) async {
      emit.call(state.copyWith(loadingSearch: true));
      await Future.delayed(const Duration(seconds: 1));
      emit.call(await _searchPokemon(event.name));
    });

    on<ClearState>((event, emit) {
      emit.call(state.copyWith(
        pokemon: [],
        loading: false,
      ));
    });
  }

  Future<PokemonState> _getPokemon() async {
    ResponseState response = await _pokemonUseCase.getPokemon();
    if (response is ResponseFailed) {
      return state.copyWith(
        pokemon: [],
        loading: false,
        isDone: false,
        hasError: true,
        errorMessage: "${response.error!.error}",
      );
    }
    return state.copyWith(
      loading: false,
      isDone: true,
      hasError: false,
      total: response.data["total"],
      pokemon: response.data["data"],
    );
  }

  Future<PokemonState> _getPokemonDetail(int id) async {
    ResponseState response = await _pokemonUseCase.getPokemonDetail(id);
    if (response is ResponseFailed) {
      return state.copyWith(
        errorMessage: "${response.error!.error}",
        loading: false,
        hasError: true,
      );
    }
    return state.copyWith(
      pokemonDetail: response.data,
      loading: false,
      hasError: false,
    );
  }

  Future<PokemonState> _searchPokemon(String name) async {
    ResponseState response = await _pokemonUseCase.searchPokemon(name);
    if (response is ResponseFailed) {
      return state.copyWith(
        errorMessage: "${response.error!.error}",
        loadingSearch: false,
        hasError: true,
        findPokemon: false,
      );
    }
    return state.copyWith(
      pokemonDetail: response.data,
      loadingSearch: false,
      hasError: false,
      findPokemon: true,
    );
  }
}
