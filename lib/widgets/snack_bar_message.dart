import 'package:flutter/material.dart';

Future snackBarMessage(
  BuildContext context,
  String message, {
  int time = 5,
  Color color = Colors.blueGrey,
}) async {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        message,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      backgroundColor: color,
      behavior: SnackBarBehavior.floating,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      duration: Duration(seconds: time),
    ),
  );
}
