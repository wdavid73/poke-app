import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poke_app/bloc/pokemon/pokemon_bloc.dart';
import 'package:poke_app/class/pokemon_obj.dart';
import 'package:poke_app/pages/pokemon/widgets/image_pokemon.dart';
import 'package:poke_app/pages/pokemon/widgets/tag_type_pokemon.dart';
import 'package:poke_app/ui/color_manager.dart';
import 'package:poke_app/utils/responsive.dart';
import 'package:poke_app/utils/types.dart';

class DetailsPokemon extends StatefulWidget {
  const DetailsPokemon({super.key});

  @override
  State<DetailsPokemon> createState() => _DetailsPokemonState();
}

class _DetailsPokemonState extends State<DetailsPokemon>
    with SingleTickerProviderStateMixin {
  static const List<Tab> myTabs = <Tab>[
    Tab(text: "About"),
    Tab(text: "Base Stats"),
    Tab(text: "Evolution"),
    Tab(text: "Moves"),
  ];
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: myTabs.length, vsync: this);
    super.initState();
  }

  Color? _getPokemonColor(Pokemon pokemon) {
    TypePokemonData? typePokemon;
    for (String type in pokemon.type) {
      typePokemon = typesPokemonData.firstWhere(
        (item) => item.name == type,
      );
      break;
    }
    if (typePokemon != null) {
      return typePokemon.color;
    }
    return Colors.grey;
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive(context);
    return BlocBuilder<PokemonBloc, PokemonState>(
      builder: (context, state) {
        Color? color = _getPokemonColor(state.pokemonSelected!);
        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            actions: [
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.favorite_border,
                ),
              )
            ],
          ),
          extendBodyBehindAppBar: true,
          body: Container(
            width: responsive.width,
            height: responsive.height,
            decoration: BoxDecoration(
              color: _getPokemonColor(state.pokemonSelected!),
              image: const DecorationImage(
                image: AssetImage('assets/images/background_details.jpg'),
                fit: BoxFit.cover,
                opacity: 0.1,
              ),
            ),
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                Positioned(
                  top: responsive.dp(10),
                  child: _titlePokemon(state, responsive),
                ),
                Positioned(
                  top: responsive.dp(24),
                  child: Container(
                    width: responsive.wp(60) / 1.1,
                    height: responsive.hp(30) / 1.1,
                    decoration: BoxDecoration(
                      color: lighten(_getPokemonColor(state.pokemonSelected!)!),
                      borderRadius: BorderRadius.circular(100),
                    ),
                  ),
                ),
                Positioned(
                  top: responsive.dp(45),
                  child: _tabPokemonDetails(responsive, state),
                ),
                Positioned(
                  top: responsive.dp(23),
                  child: Container(
                    /* width: responsive.wp(55),
                    height: responsive.hp(30), */
                    color: Colors.transparent,
                    child: FittedBox(
                      fit: BoxFit.fill,
                      child: ImagePokemon(
                        pokemon: state.pokemonSelected!,
                        responsive: responsive,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  SizedBox _tabPokemonDetails(Responsive responsive, PokemonState state) {
    return SizedBox(
      width: responsive.width,
      height: responsive.hp(75),
      child: Column(
        children: [
          Container(
            width: responsive.width,
            height: responsive.hp(50),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Column(
              children: [
                SizedBox(
                  height: responsive.hp(10),
                  child: TabBar(
                    controller: _tabController,
                    tabs: myTabs,
                    indicatorColor: ColorManager.waterColor,
                    labelColor: ColorManager.textPrimary,
                    unselectedLabelColor: ColorManager.textSecondary,
                    automaticIndicatorColorAdjustment: true,
                    padding: const EdgeInsets.only(left: 4, right: 5),
                    indicatorPadding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 10,
                    ),
                    labelPadding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 0,
                    ),
                    indicatorSize: TabBarIndicatorSize.tab,
                    isScrollable: true,
                  ),
                ),
                SizedBox(
                  height: responsive.hp(40),
                  child: TabBarView(
                    controller: _tabController,
                    children: myTabs.map((Tab tab) {
                      final String label = tab.text!.toLowerCase();
                      return Center(
                        child: Text(
                          'This is the $label tab',
                          style: TextStyle(
                            fontSize: responsive.dp(1.5),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _titlePokemon(PokemonState state, Responsive responsive) {
    return SizedBox(
      width: responsive.width,
      height: responsive.hp(12),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "nombre: ${state.pokemonSelected!.name}",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: responsive.dp(3),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "#${state.pokemonSelected!.id}",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: responsive.dp(2),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TagTypePokemon(
                  orientation: 'horizontal',
                  types: state.pokemonSelected!.type,
                  width: responsive.wp(50),
                  height: responsive.hp(5),
                  lightenColor: true,
                ),
                Text(
                  "Extra",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: responsive.dp(2),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
