import 'package:flutter/material.dart';
import 'package:poke_app/class/typepokemon.dart';
import 'package:poke_app/utils/hex_color.dart';

class TagTypePokemon extends StatelessWidget {
  final List<Typepokemon> types;
  final double width;
  final double height;

  const TagTypePokemon({
    super.key,
    required this.types,
    required this.width,
    this.height = 20,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: GridView.count(
        crossAxisCount: 2,
        childAspectRatio: 2,
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
                    '${types[index].name}',
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
