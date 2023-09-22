import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:poke_app/utils/responsive.dart';

class WaterMark extends StatelessWidget {
  final double opacity;
  final Color color;
  final double size;
  const WaterMark({
    super.key,
    required this.opacity,
    this.color = Colors.white,
    this.size = 15,
  });

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Align(
        alignment: Alignment.bottomRight,
        child: Opacity(
          opacity: opacity,
          child: SvgPicture.asset(
            'assets/icons/pokebola.svg',
            alignment: Alignment.bottomRight,
            width: responsive.dp(size),
            height: responsive.dp(size),
            colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
          ),
        ),
      ),
    );
  }
}
