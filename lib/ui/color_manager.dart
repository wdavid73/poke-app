import 'package:flutter/material.dart';

class ColorManager {
  static Color textPrimary = HexColor("#212121");
  static Color textSecondary = HexColor("#757575");

  static Color backgroundColor = HexColor("#E8E8E8");

  static Color white = Colors.white;
  static Color lightGrey = HexColor("#d5d6cf");
  static Color lightGreyVariation = HexColor("#EBEEF5");
  static Color darkGrey = HexColor("#a4a59e");
  static Color error = HexColor("#EF5350");
  static Color divider = HexColor("#BDBDBD");

  static Color normalColor = HexColor("#A8A77A");
  static Color fireColor = HexColor("#EE8130");
  static Color waterColor = HexColor("#6390F0");
  static Color grassColor = HexColor("#7AC74C");
  static Color electricColor = HexColor("#F7D02C");
  static Color iceColor = HexColor("#96D9D6");
  static Color fightingColor = HexColor("#C22E28");
  static Color poisonColor = HexColor("#A33EA1");
  static Color groundColor = HexColor("#E2BF65");
  static Color flyingColor = HexColor("#A98FF3");
  static Color psychicColor = HexColor("#F95587");
  static Color bugColor = HexColor("#A6B91A");
  static Color rockColor = HexColor("#B6A136");
  static Color ghostColor = HexColor("#735797");
  static Color dragonColor = HexColor("#6F35FC");
  static Color darkColor = HexColor("#705746");
  static Color steelColor = HexColor("#B7B7CE");
  static Color fairyColor = HexColor("#D685AD");
}

class HexColor extends Color {
  static int _getColorFromHex(String? hexColor) {
    hexColor = hexColor!.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = 'FF$hexColor';
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String? hexColor) : super(_getColorFromHex(hexColor));
}

Color lighten(Color color, [double amount = .1]) {
  assert(amount >= 0 && amount <= 1);

  final hsl = HSLColor.fromColor(color);
  final hslLight = hsl.withLightness((hsl.lightness + amount).clamp(0.0, 1.0));

  return hslLight.toColor();
}
