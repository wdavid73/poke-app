part of 'pokemon_bloc.dart';

@immutable
abstract class PokemonEvent {}

class GetPokemon extends PokemonEvent {}

class ReduceListPokemon extends PokemonEvent {}

class FindPokemon extends PokemonEvent {
  final String name;

  FindPokemon(this.name);
}

class CreatePokemonEvent extends PokemonEvent {
  final PokemonFile pokemon;

  CreatePokemonEvent(this.pokemon);
}

class SetLoading extends PokemonEvent {
  final bool loading;

  SetLoading(this.loading);
}

class ResetStateCreatedPokemon extends PokemonEvent {}

class SetPokemon extends PokemonEvent {
  final Pokemon pokemon;

  SetPokemon(this.pokemon);
}

class DeletePokemon extends PokemonEvent {
  final int idPokemon;
  DeletePokemon(this.idPokemon);
}

class ClearState extends PokemonEvent {}
