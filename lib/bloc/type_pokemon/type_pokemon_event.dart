part of 'type_pokemon_bloc.dart';

abstract class TypePokemonEvent {}

class GetTypePokemon extends TypePokemonEvent {}

class GetTypePokemonRefresh extends TypePokemonEvent {}
