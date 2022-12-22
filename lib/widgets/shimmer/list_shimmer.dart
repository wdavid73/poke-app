import 'package:flutter/material.dart';
import 'package:poke_app/utils/responsive.dart';

class ListShimmer extends StatelessWidget {
  final Responsive responsive;
  final int countItems;
  final String size;

  const ListShimmer({
    Key? key,
    required this.responsive,
    this.countItems = 6,
    this.size = "lg",
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: responsive.height,
      child: ListView(
        children: List.generate(
          countItems,
          (index) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: responsive.hp(12),
                  width: responsive.wp(25),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
                SizedBox(
                  height: responsive.hp(15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Container(
                        width: responsive.wp(40),
                        height: responsive.hp(3),
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      size == "md" || size == "lg"
                          ? Container(
                              width: responsive.wp(37),
                              height: responsive.hp(3),
                              decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.circular(10),
                              ),
                            )
                          : Container(),
                      size == "lg"
                          ? Container(
                              width: responsive.wp(25),
                              height: responsive.hp(3),
                              decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.circular(10),
                              ),
                            )
                          : Container(),
                    ],
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
