import 'package:flutter/material.dart';

@immutable
class ColorSchemer {
  static Color iconIndicatorColor = const Color(0xFF9E3773).withOpacity(0.7);
  static Color vismaBlack = const Color(0xFF191919);
  static Color textColor = vismaBlack;

  // vertical line
  static Color palicaColor = vismaBlack.withOpacity(0.3);

  // shadow around dots on palice
  static Color indicatorShadowColor = vismaBlack.withOpacity(0.3);

  static ThemeData lightTheme() => ThemeData(
        primarySwatch: Colors.amber,
      );

  static ThemeData darkTheme() => ThemeData.dark();

  const ColorSchemer._();
}
