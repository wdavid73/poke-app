import 'package:flutter/material.dart';
import 'package:poke_app/utils/responsive.dart';

class DialogContainer extends StatelessWidget {
  final Widget child;
  const DialogContainer({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive(context);
    final double pinkSize = responsive.wp(85);
    final double orangeSize = responsive.wp(55);

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Container(
          width: responsive.width,
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: Colors.white,
            borderRadius: BorderRadius.circular(25),
          ),
          child: Stack(
            clipBehavior: Clip.antiAlias,
            children: [
              Positioned(
                top: -pinkSize * 0.2,
                right: -pinkSize * 0.2,
                child: Circle(
                  size: pinkSize,
                  colors: const [
                    Colors.blueAccent,
                    Colors.lightBlue,
                  ],
                ),
              ),
              Positioned(
                top: -orangeSize * 0.55,
                left: -orangeSize * 0.15,
                child: Circle(
                  size: orangeSize,
                  colors: const [
                    Colors.deepPurple,
                    Colors.deepPurpleAccent,
                  ],
                ),
              ),
              child,
            ],
          ),
        ),
      ),
    );
  }
}

class Circle extends StatelessWidget {
  final double size;
  final List<Color> colors;

  const Circle({
    Key? key,
    required this.size,
    required this.colors,
  })  : assert(size > 0),
        assert(colors.length >= 2),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          colors: colors,
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
    );
  }
}