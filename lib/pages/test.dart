import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:poke_app/utils/my_colors.dart';
import 'package:poke_app/utils/responsive.dart';

class TestPage extends StatefulWidget {
  const TestPage({Key? key}) : super(key: key);

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  int value = 0;

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive(context);
    return Scaffold(
      body: SizedBox(
        child: Column(
          children: [
            Container(
              width: responsive.width,
              height: responsive.hp(50),
              color: Colors.redAccent,
              child: Center(
                child: Text(
                  "Horizontal gesture",
                  style: TextStyle(
                    fontSize: responsive.dp(4),
                    color: MyColors.lightPrimaryColor,
                  ),
                ),
              ),
            ),
            GestureDetector(
              onHorizontalDragUpdate: (e) {
                if (e.delta.dx > 0) {
                  print('horizontal : 1');
                  setState(() {
                    value = 1;
                  });
                } else {
                  print('horizontal : 0');
                  setState(() {
                    value = 0;
                  });
                }
              },
              child: Container(
                width: responsive.width,
                height:
                    responsive.isTablet ? responsive.hp(50) : responsive.hp(30),
                color: value == 1 ? Colors.blueAccent : Colors.pinkAccent,
                child: Center(
                  child: Text(
                    "Horizontal gesture ${value == 1 ? 'left-right' : 'right-left'}",
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      // fontWeight: FontWeight.bold,
                      color: MyColors.lightPrimaryColor,
                      fontSize: responsive.dp(4),
                    ),
                  ),
                ),
              ),
            ),
            /*
            GestureDetector(
          onHorizontalDragUpdate: (e) {
            if (e.delta.dx > 0) {
              setState(() {
                value = 1;
              });
            } else {
              setState(() {
                value = 0;
              });
            }
          },
        ),
        * */
          ],
        ),
      ),
    );
  }
}
