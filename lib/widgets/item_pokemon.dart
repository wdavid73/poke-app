import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poke_app/bloc/pokemon/pokemon_bloc.dart';
import 'package:poke_app/class/pokemon_obj.dart';
import 'package:poke_app/utils/responsive.dart';
import 'package:poke_app/widgets/image_pokemon.dart';
import 'package:poke_app/widgets/tag_type_pokemon.dart';

class ItemPokemon extends StatefulWidget {
  final Pokemon pokemon;
  final Responsive responsive;

  const ItemPokemon({
    super.key,
    required this.pokemon,
    required this.responsive,
  });

  @override
  State<ItemPokemon> createState() => _ItemPokemonState();
}

class _ItemPokemonState extends State<ItemPokemon> {

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.responsive.hp(45),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: GestureDetector(
          child: Card(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
              side: const BorderSide(
                color: Colors.white,
              ),
            ),
            child: InkWell(
              onLongPress: () => {
                BlocProvider.of<PokemonBloc>(context).add(
                  SetPokemon(widget.pokemon),
                ),
                Navigator.pushNamed(context, 'details_pokemon'),
                // setPokemonItem(widget.pokemon),
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    flex: 2,
                    child: ImagePokemon(
                      pokemon: widget.pokemon,
                      responsive: widget.responsive,
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 5,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            widget.pokemon.name,
                            style: TextStyle(
                              fontSize: widget.responsive.dp(1.9),
                            ),
                          ),
                          TagTypePokemon(
                            types: widget.pokemon.type,
                            width: widget.responsive.width,
                            height: widget.responsive.hp(5),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
