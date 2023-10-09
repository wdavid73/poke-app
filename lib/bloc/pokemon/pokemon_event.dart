part of 'pokemon_bloc.dart';

@immutable
abstract class PokemonEvent {}

class GetPokemon extends PokemonEvent {}

class ClearState extends PokemonEvent {}
