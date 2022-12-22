part of 'type_pokemon_bloc.dart';

@immutable
abstract class TypePokemonEvent {}

class GetTypePokemon extends TypePokemonEvent {}
class GetTypePokemonRefresh extends TypePokemonEvent {}
