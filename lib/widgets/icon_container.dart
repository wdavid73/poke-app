import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class IconContainer extends StatelessWidget {
  final double size;
  final String iconUrl;
  final Color color;
  final bool shadow;
  final bool fullPath;
  const IconContainer({
    Key? key,
    required this.size,
    required this.iconUrl,
    this.color = Colors.transparent,
    required this.shadow,
    this.fullPath = false,
  })  : assert(size > 0),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(
          size * 0.15,
        ),
        boxShadow: shadow
            ? [
                const BoxShadow(
                  color: Colors.black12,
                  blurRadius: 20,
                  offset: Offset(0, 15),
                )
              ]
            : [],
      ),
      padding: EdgeInsets.all(size * 0.15),
      child: Center(
        child: SvgPicture.asset(
          !fullPath ? "assets/icons/$iconUrl" : iconUrl,
          width: size * 0.8,
          height: size * 0.8,
        ),
      ),
    );
  }
}
