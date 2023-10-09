import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poke_app/class/type_pokemon.dart';

part 'type_pokemon_event.dart';
part 'type_pokemon_state.dart';

class TypePokemonBloc extends Bloc<TypePokemonEvent, TypePokemonState> {
  TypePokemonBloc() : super(TypePokemonState()) {
    on<TypePokemonEvent>((event, emit) async {
      // event get type pokemon
      if (event is GetTypePokemon) {
        /* emit.call(_setLoading(true));
        emit.call(await _getTypePokemon());
        emit.call(_setLoading(false)); */
      }

      if (event is GetTypePokemonRefresh) {
        /* await Future<void>.delayed(const Duration(seconds: 3));
        emit.call(_setLoading(true));
        emit.call(await _getTypePokemon());
        emit.call(_setLoading(false)); */
      }
    });
  }
}
