import 'package:flutter/material.dart';
import 'package:poke_app/class/pokemon_obj.dart';
import 'package:poke_app/utils/navigation_manager.dart';
import 'package:poke_app/utils/responsive.dart';
import 'package:poke_app/utils/string_extension.dart';
import 'package:poke_app/pages/pokemon/widgets/image_pokemon.dart';
import 'package:poke_app/widgets/water_mark.dart';

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
    return GestureDetector(
      onTap: () {
        NavigationManager.go(
          context,
          "details_pokemon",
          data: widget.pokemon,
        );
      },
      child: Card(
        color: Colors.blueAccent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
          side: const BorderSide(
            color: Colors.white,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Stack(
            children: [
              const Positioned(
                top: 10,
                right: -15,
                child: WaterMark(
                  opacity: 0.5,
                  size: 10,
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        widget.pokemon.name.capitalize(),
                        style: TextStyle(
                          fontSize: widget.responsive.dp(1.9),
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      /* TagTypePokemon(
                        types: widget.pokemon.type,
                        width: widget.responsive.wp(15),
                        height: widget.responsive.hp(8),
                      ), */
                    ],
                  ),
                  Expanded(
                    child: ImagePokemon(
                      pokemon: widget.pokemon,
                      responsive: widget.responsive,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
