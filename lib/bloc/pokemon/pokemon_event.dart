part of 'pokemon_bloc.dart';

@immutable
abstract class PokemonEvent {}

class GetPokemon extends PokemonEvent {}

class GetPokemonDetail extends PokemonEvent {
  final int id;
  GetPokemonDetail({required this.id});
}

class ClearState extends PokemonEvent {}
