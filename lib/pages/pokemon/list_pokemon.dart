import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poke_app/bloc/pokemon/pokemon_bloc.dart';
import 'package:poke_app/utils/responsive.dart';
import 'package:poke_app/pages/pokemon/widgets/item_pokemon.dart';
import 'package:poke_app/widgets/shimmer/grid_shimmer.dart';
import 'package:shimmer/shimmer.dart';

class ListPokemon extends StatelessWidget {
  const ListPokemon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Responsive responsive = Responsive(context);

    return BlocBuilder<PokemonBloc, PokemonState>(
      builder: (context, state) {
        if (state.loading) {
          return SizedBox(
            width: responsive.width,
            height: responsive.height,
            child: Shimmer.fromColors(
              baseColor: Colors.black26,
              highlightColor: Colors.black12,
              child: GridShimmer(
                responsive: responsive,
              ),
            ),
          );
        }
        if (state.isDone) {
          return Container(
            height: responsive.hp(80),
            width: responsive.width,
            padding: const EdgeInsets.all(10),
            child: GridView.count(
              padding: EdgeInsets.zero,
              crossAxisCount: 2,
              childAspectRatio: (1 / .6),
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
        }
        if (state.hasError) {
          return SizedBox(
            width: responsive.width,
            height: responsive.hp(75),
            child: Center(
              child: Text(
                "Has error!",
                style: TextStyle(
                  color: Colors.red,
                  fontSize: responsive.dp(3),
                ),
              ),
            ),
          );
        }
        return SizedBox(
          width: responsive.width,
          height: responsive.height,
          child: const Center(
            child: Text("no data"),
          ),
        );
      },
    );
  }
}
