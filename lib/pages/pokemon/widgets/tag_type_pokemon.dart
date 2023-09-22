import 'package:flutter/material.dart';
import 'package:poke_app/ui/color_manager.dart';
import 'package:poke_app/utils/responsive.dart';
import 'package:poke_app/utils/types.dart';

class TagTypePokemon extends StatelessWidget {
  final List<String> types;
  final double width;
  final double height;
  final int count;
  final double aspectRatio;
  final double? spaceVertical;
  final double? spaceHorizontal;
  final String orientation;
  final bool lightenColor;

  const TagTypePokemon({
    super.key,
    required this.types,
    required this.width,
    this.height = 20,
    this.count = 2,
    this.aspectRatio = 2,
    this.spaceVertical,
    this.spaceHorizontal,
    this.orientation = 'vertical',
    this.lightenColor = false,
  });

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive(context);
    return SizedBox(
      height: height,
      width: width,
      child: orientation == 'horizontal'
          ? Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: List.generate(
                types.length,
                (index) {
                  Color color = typesPokemonData
                      .firstWhere((element) => element.name == types[index])
                      .color;

                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Container(
                      decoration: BoxDecoration(
                        color: lightenColor ? lighten(color) : color,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          child: Text(
                            types[index],
                            style: TextStyle(
                              fontSize: responsive.dp(2),
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ))
          : Column(
              children: List.generate(
                types.length,
                (index) {
                  Color color = typesPokemonData
                      .firstWhere((element) => element.name == types[index])
                      .color;

                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Container(
                      decoration: BoxDecoration(
                        color: color,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Center(
                        child: Text(
                          types[index],
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
