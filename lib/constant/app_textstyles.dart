import 'package:flutter/material.dart';

class AppTextStyles {
  static TextStyle _baseTextStyle({Color color = Colors.black}) {
    return TextStyle(
      color: color,
    );
  }

  // Heading style
  static TextStyle heading({Color color = Colors.black}) {
    return _baseTextStyle(color: color).copyWith(
      fontSize: 35.0,
      fontWeight: FontWeight.bold,
    );
  }

  static TextStyle title({Color color = Colors.black}) {
    return _baseTextStyle(color: color).copyWith(
      fontSize: 22.0,
      fontWeight: FontWeight.w800,
    );
  }

  // Subtitle style
  static TextStyle subtitle({Color color = Colors.black}) {
    return _baseTextStyle(color: color).copyWith(
      fontSize: 18.0,
      fontWeight: FontWeight.w500,
    );
  }

  // Body large style
  static TextStyle bodyLarge({Color color = Colors.black}) {
    return _baseTextStyle(color: color).copyWith(
      fontSize: 16.0,
      fontWeight: FontWeight.normal,
    );
  }

  // Body medium style
  static TextStyle bodyMedium({Color color = Colors.black}) {
    return _baseTextStyle(color: color).copyWith(
      fontSize: 14.0,
      fontWeight: FontWeight.normal,
    );
  }

  // Body small style
  static TextStyle bodySmall({Color color = Colors.black}) {
    return _baseTextStyle(color: color).copyWith(
      fontSize: 12.0,
      fontWeight: FontWeight.normal,
    );
  }
}
