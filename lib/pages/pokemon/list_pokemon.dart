import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poke_app/bloc/pokemon/pokemon_bloc.dart';
import 'package:poke_app/utils/responsive.dart';
import 'package:poke_app/widgets/item_pokemon.dart';

class ListPokemon extends StatelessWidget {
  const ListPokemon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Responsive responsive = Responsive(context);

    return BlocBuilder<PokemonBloc, PokemonState>(builder: (context, state) {
      return SizedBox(
        height: responsive.hp(75),
        child: GridView.count(
          crossAxisCount: 2,
          childAspectRatio: (responsive.width / responsive.height) * 1.5,
          children: List.generate(
            state.pokemonFiltered.isEmpty
                ? state.pokemon.length
                : state.pokemonFiltered.length,
            (index) {
              return ItemPokemon(
                responsive: responsive,
                pokemon: state.pokemonFiltered.isEmpty
                    ? state.pokemon[index]
                    : state.pokemonFiltered[index],
              );
            },
          ),
        ),
      );
    });
  }
}
