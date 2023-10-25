import 'package:flutter/material.dart';
import 'package:poke_app/class/pokemon_obj.dart';
import 'package:poke_app/utils/navigation_manager.dart';
import 'package:poke_app/utils/responsive.dart';
import 'package:poke_app/utils/string_extension.dart';
import 'package:poke_app/pages/pokemon/widgets/image_pokemon.dart';
import 'package:poke_app/widgets/water_mark.dart';

class ItemPokemon extends StatelessWidget {
  final Pokemon pokemon;

  const ItemPokemon({
    super.key,
    required this.pokemon,
  });

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive(context);
    return GestureDetector(
      onTap: () {
        NavigationManager.go(
          context,
          "details_pokemon",
          data: pokemon,
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
            alignment: Alignment.center,
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
                        "${pokemon.name.capitalize()}",
                        textDirection: TextDirection.ltr,
                        style: TextStyle(
                          fontSize: responsive.dp(1.9),
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      /* TagTypePokemon(
                        types:  pokemon.type,
                        width:  responsive.wp(15),
                        height:  responsive.hp(8),
                      ), */
                    ],
                  ),
                  Expanded(
                    child: ImagePokemon(
                      pokemon: pokemon,
                      responsive: responsive,
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
