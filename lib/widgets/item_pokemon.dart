import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:poke_app/class/pokemon_obj.dart';
import 'package:poke_app/utils/responsive.dart';
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
        child: Card(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
            side: const BorderSide(
              color: Colors.white,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                flex: 2,
                child: ExtendedImage.network(
                  widget.pokemon.image,
                  width: widget.responsive.wp(55),
                  fit: BoxFit.fill,
                  cache: true,
                  border: Border.all(color: Colors.white, width: 1.0),
                  shape: BoxShape.rectangle,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  ),
                  loadStateChanged: (ExtendedImageState state) {
                    switch (state.extendedImageLoadState) {
                      case LoadState.loading:
                        return null;
                      case LoadState.completed:
                        return null;
                      case LoadState.failed:
                        return GestureDetector(
                          child: Stack(
                            children: <Widget>[
                              /* Center(
                                child: Image.asset(
                                  "assets/images/failed.png",
                                  height: widget.responsive.hp(20),
                                  width: widget.responsive.wp(20),
                                ),
                              ), */
                              Positioned(
                                bottom: 0.0,
                                left: 0.0,
                                right: 0.0,
                                child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Text(
                                    "load image failed, click to reload",
                                    style: TextStyle(
                                      fontSize: widget.responsive.dp(1.3),
                                      fontWeight: FontWeight.bold,
                                      color: Colors.redAccent,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              )
                            ],
                          ),
                          onTap: () {
                            state.reLoadImage();
                          },
                        );
                    }
                  },
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
    );
  }
}
