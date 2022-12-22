import 'package:flutter/material.dart';
import 'package:poke_app/class/type_pokemon.dart';
import 'package:poke_app/utils/hex_color.dart';

class TagTypePokemon extends StatelessWidget {
  final List<TypePokemon> types;
  final double width;
  final double height;
  final int count;
  final double aspectRatio;
  final double? spaceVertical;
  final double? spaceHorizontal;

  const TagTypePokemon({
    super.key,
    required this.types,
    required this.width,
    this.height = 20,
    this.count = 2,
    this.aspectRatio = 2,
    this.spaceVertical, this.spaceHorizontal,

  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: GridView.count(
        crossAxisCount: count,
        childAspectRatio: aspectRatio,
        padding: const EdgeInsets.only(bottom: 20),
        crossAxisSpacing: spaceHorizontal ?? 0,
        mainAxisSpacing: spaceVertical ?? 0,
        shrinkWrap: true,
        children: List.generate(
          types.length,
          (index) {
            Color color = HexColor(types[index].color);
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 3),
              child: Container(
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Center(
                  child: Text(
                    types[index].name,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
