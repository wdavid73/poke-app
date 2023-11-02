import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poke_app/bloc/pokemon/pokemon_bloc.dart';
import 'package:poke_app/bloc/type_pokemon/type_pokemon_bloc.dart';
import 'package:poke_app/services/api.dart';
import 'package:poke_app/services/repositories/repository_pokemon.dart';
import 'package:poke_app/services/repositories_impl/repository_pokemon_impl.dart';
import 'package:poke_app/services/usecases/pokemon_usecase.dart';

List<RepositoryProvider> buildRepositories() {
  return [
    RepositoryProvider<PokemonRepository>(
      create: (context) => PokemonRepositoryImpl(ApiClient.instance),
    ),
    RepositoryProvider<PokemonUseCase>(
      create: ((context) => PokemonUseCase(context.read())),
    ),
  ];
}

List<BlocProvider> buildBlocs() {
  return [
    BlocProvider<PokemonBloc>(
      create: (context) => PokemonBloc(context.read()),
    ),
    BlocProvider<TypePokemonBloc>(
      create: (context) => TypePokemonBloc(),
    ),
  ];
}
