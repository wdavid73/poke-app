part of 'pokemon_bloc.dart';

@immutable
abstract class PokemonEvent {}

class GetPokemon extends PokemonEvent {}

class ReduceListPokemon extends PokemonEvent {}

class FindPokemon extends PokemonEvent {
  final String name;
  FindPokemon(this.name);
}
