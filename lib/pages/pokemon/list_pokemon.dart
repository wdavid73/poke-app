import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poke_app/bloc/pokemon/pokemon_bloc.dart';
import 'package:poke_app/pages/pokemon/widgets/item_pokemon.dart';
import 'package:poke_app/ui/color_manager.dart';
import 'package:poke_app/utils/navigation_manager.dart';
import 'package:poke_app/utils/responsive.dart';
import 'package:poke_app/widgets/shimmer/grid_shimmer.dart';
import 'package:poke_app/widgets/water_mark.dart';
import 'package:shimmer/shimmer.dart';

class ListPokemon extends StatefulWidget {
  const ListPokemon({super.key});

  @override
  State<ListPokemon> createState() => _ListPokemonState();
}

class _ListPokemonState extends State<ListPokemon> {
  @override
  void initState() {
    _init();
    super.initState();
  }

  void _init() {
    _getPokemon();
  }

  Future<void> _getPokemon() async {
    final pokemonBloc = BlocProvider.of<PokemonBloc>(context);
    pokemonBloc.add(GetPokemon());
  }

  @override
  Widget build(BuildContext context) {
    Responsive responsive = Responsive(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.black,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            NavigationManager.go(context, "home");
          },
        ),
      ),
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              width: responsive.width,
              height: responsive.height,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  _titlePage(responsive),
                  _waterMark(responsive),
                  Positioned(
                    top: responsive.dp(15),
                    child: RefreshIndicator(
                      onRefresh: () async {
                        // print("reload");
                      },
                      child: BlocBuilder<PokemonBloc, PokemonState>(
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
                                  state.pokemon.length,
                                  (index) {
                                    return ItemPokemon(
                                      responsive: responsive,
                                      pokemon: state.pokemon[index],
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
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: responsive.wp(70),
                                    child: Text(
                                      state.errorMessage,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.red,
                                        fontSize: responsive.dp(2.7),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: responsive.wp(50),
                                    child: ElevatedButton(
                                      onPressed: () {},
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "Reload",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: responsive.dp(2),
                                            ),
                                          ),
                                          const SizedBox(width: 10),
                                          Icon(
                                            Icons.replay_outlined,
                                            color: Colors.white,
                                            size: responsive.dp(4),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
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
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: responsive.hp(1),
            ),
          ],
        ),
      ),
    );
  }

  Positioned _waterMark(Responsive responsive) {
    return Positioned(
      left: responsive.wp(60),
      top: -responsive.hp(10),
      child: const WaterMark(
        opacity: 0.2,
        color: Colors.grey,
        size: 30,
      ),
    );
  }

  Positioned _titlePage(Responsive responsive) {
    return Positioned(
      left: 20,
      top: responsive.dp(10),
      child: Text(
        "Pokedex",
        textAlign: TextAlign.left,
        style: TextStyle(
          color: ColorManager.textPrimary,
          fontWeight: FontWeight.bold,
          fontSize: responsive.dp(3),
        ),
      ),
    );
  }
}
