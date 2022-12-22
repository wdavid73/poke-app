import 'package:flutter/material.dart';
import 'package:poke_app/utils/responsive.dart';

class GridShimmer extends StatelessWidget {
  final Responsive responsive;
  final int numItems;
  final double ratio;

  const GridShimmer({
    Key? key,
    required this.responsive,
    this.numItems = 2,
    this.ratio = 1.7,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: responsive.height,
      child: GridView.count(
        crossAxisCount: numItems,
        childAspectRatio: (responsive.width / responsive.height) * ratio,
        children: List.generate(6, (index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Container(
                  height: responsive.hp(15),
                  width: responsive.width,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: Container(
                      height: responsive.hp(2.5),
                      width: responsive.wp(40),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: Container(
                      height: responsive.hp(2.5),
                      width: responsive.wp(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: Container(
                      height: responsive.hp(2.5),
                      width: responsive.wp(30),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
