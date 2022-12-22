import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:poke_app/class/type_pokemon.dart';
import 'package:poke_app/services/repositories/repository_type_pokemon.dart';

part 'type_pokemon_event.dart';
part 'type_pokemon_state.dart';

class TypePokemonBloc extends Bloc<TypePokemonEvent, TypePokemonState> {
  final TypePokemonRepository _typePokemonRepository = TypePokemonRepository();

  TypePokemonBloc() : super(TypePokemonState()) {
    on<TypePokemonEvent>((event, emit) async {
      // event get type pokemon
      if (event is GetTypePokemon) {
        emit.call(_setLoading(true));
        emit.call(await _getTypePokemon());
        emit.call(_setLoading(false));
      }

      if (event is GetTypePokemonRefresh) {
        await Future<void>.delayed(const Duration(seconds: 3));
        emit.call(_setLoading(true));
        emit.call(await _getTypePokemon());
        emit.call(_setLoading(false));
      }
    });
  }

  Future<TypePokemonState> _getTypePokemon() async {
    try {
      state.copyWith(isDone: false);
      dynamic data = await _typePokemonRepository.getTypePokemon();
      List<TypePokemon> typePokemon = data;
      return state.copyWith(
        typePokemon: typePokemon,
        isDone: true,
        hasError: false,
      );
    } catch (e) {
      return state.copyWith(
        typePokemon: <TypePokemon>[],
        isDone: false,
        hasError: true,
      );
    }
  }

  TypePokemonState _setLoading(bool loading) {
    return state.copyWith(loading: loading);
  }
}
