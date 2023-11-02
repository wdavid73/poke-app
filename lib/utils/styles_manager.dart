import 'package:flutter/material.dart';

TextStyle _getTextStyle(
  double fontSize,
  FontWeight fontWeight,
  Color? color, {
  TextDecoration? textDecoration,
  FontStyle? fontStyle,
}) {
  return TextStyle(
    fontSize: fontSize,
    fontWeight: fontWeight,
    color: color,
    decoration: textDecoration,
    fontStyle: fontStyle,
  );
}

TextStyle getLightStyle({
  double fontSize = 12,
  Color? color,
  TextDecoration? textDecoration,
  FontStyle? fontStyle,
}) {
  return _getTextStyle(
    fontSize,
    FontWeight.normal,
    color,
    textDecoration: textDecoration,
    fontStyle: fontStyle,
  );
}

TextStyle getRegularStyle({
  double fontSize = 12,
  Color? color,
  TextDecoration? textDecoration,
  FontStyle? fontStyle,
}) {
  return _getTextStyle(
    fontSize,
    FontWeight.normal,
    color,
    textDecoration: textDecoration,
    fontStyle: fontStyle,
  );
}

TextStyle getMediumStyle({
  double fontSize = 12,
  Color? color,
  TextDecoration? textDecoration,
  FontStyle? fontStyle,
}) {
  return _getTextStyle(
    fontSize,
    FontWeight.w300,
    color,
    textDecoration: textDecoration,
    fontStyle: fontStyle,
  );
}

TextStyle getSemiBoldStyle({
  double fontSize = 12,
  Color? color,
  TextDecoration? textDecoration,
  FontStyle? fontStyle,
}) {
  return _getTextStyle(
    fontSize,
    FontWeight.w400,
    color,
    textDecoration: textDecoration,
    fontStyle: fontStyle,
  );
}

TextStyle getBoldStyle({
  double fontSize = 12,
  Color? color,
  TextDecoration? textDecoration,
  FontStyle? fontStyle,
}) {
  return _getTextStyle(
    fontSize,
    FontWeight.bold,
    color,
    textDecoration: textDecoration,
    fontStyle: fontStyle,
  );
}
