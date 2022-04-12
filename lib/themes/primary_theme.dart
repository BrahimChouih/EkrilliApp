import 'package:flutter/material.dart';

ThemeData primaryTheme = ThemeData.light().copyWith(
  primaryColor: primaryColor,
  scaffoldBackgroundColor: backgroundColor,
  textTheme: ThemeData.light().textTheme.apply(
        fontFamily: 'VarelaRound',
        bodyColor: const Color(0xff707070),
      ),
);

const Color primaryColor = Color(0xff3CCEA5);
const Color backgroundColor = Color(0xffF5FFFC);
