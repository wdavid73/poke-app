import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:poke_app/class/pokemon_obj.dart';
import 'package:poke_app/utils/responsive.dart';

class ImagePokemon extends StatelessWidget {
  const ImagePokemon({
    Key? key,
    required this.pokemon,
    required this.responsive,
    this.widthImage,
  }) : super(key: key);

  final Pokemon pokemon;
  final Responsive responsive;
  final double? widthImage;

  @override
  Widget build(BuildContext context) {
    return ExtendedImage.network(
      pokemon.image,
      width: widthImage ?? responsive.wp(55),
      fit: BoxFit.fill,
      cache: true,
      border: Border.all(color: Colors.white, width: 1.0),
      shape: BoxShape.rectangle,
      borderRadius: const BorderRadius.all(Radius.circular(15)),
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
                          fontSize: responsive.dp(1.3),
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
    );
  }
}
