import 'package:flutter/material.dart';

class AppColors {
  static const int _greyPrimaryValue = 0xFF808080;

  static const MaterialColor grey = MaterialColor(
    _greyPrimaryValue,
    <int, Color>{
      50: Color(0xFFe5e4e2),
      100: Color(0xFFf8f6f4),
      200: Color(0xFF808080),
      300: Color(0xFF808080),
      400: Color(0xFF808080),
      500: Color(0xFF808080),
      600: Color(0xFF808080),
      700: Color(0xFF808080),
      800: Color(0xFF808080),
      900: Color(0xFF006eff),
    },
  );

  static const Color textColorDark = Colors.white;
  static const Color textColorLight = Colors.black;
}
