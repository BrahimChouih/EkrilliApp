import 'package:flutter/material.dart';

import '../utils/constants.dart';

ThemeData primaryTheme = ThemeData.light().copyWith(
  primaryColor: primaryColor,
  colorScheme: ColorScheme.light().copyWith(
    primary: primaryColor,
    secondary: primaryColor,
  ),
  scaffoldBackgroundColor: backgroundColor,
  textTheme: ThemeData.light().textTheme.apply(
        fontFamily: 'VarelaRound',
        bodyColor: const Color(0xff707070),
      ),
);
