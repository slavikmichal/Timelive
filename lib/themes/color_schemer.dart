import 'package:flutter/material.dart';

@immutable
class ColorSchemer {
  static Color iconIndicatorColor = VismaColorScheme.orange;
  static Color vismaBlack = VismaColorScheme.black;
  static Color textColor = VismaColorScheme.black;

  static Color buttonColor = VismaColorScheme.orange;

  // vertical line
  static Color palicaColor = vismaBlack.withOpacity(0.5);

  // shadow around dots on palice
  static Color indicatorShadowColor = VismaColorScheme.shadow;

  static ThemeData lightTheme() => ThemeData(primarySwatch: Colors.red);

  static ThemeData darkTheme() => ThemeData.dark();

  const ColorSchemer._();
}

@immutable
class VismaColorScheme {
  static Color black = const Color(0xFF191919);
  static Color white = const Color(0xFFFFFFFF);
  static Color shadow = const Color(0xFFDCDCDC);

  // Visma Signal Colours
  static Color red = const Color(0xFFF01245);
  static Color orange = const Color(0xFFF75447);
  static Color pink = const Color(0xFFFA54DB);
  static Color darkBlue = const Color(0xFF007ACA);
  static Color blue = const Color(0xFF099DE3);
  static Color ocean = const Color(0xFF02D1E4);
  static Color forest = const Color(0xFF0FAB4D);
  static Color green = const Color(0xFF1AE533);
  static Color yellow = const Color(0xFFE8FC25);

  // Visma Foundation Colours
  static Color redFoundation = const Color(0xFF93002C);
  static Color salmonFoundation = const Color(0xFFe88b8f);
  static Color oceanFoundation = const Color(0xFF4d7b93);
  static Color deepOceanFoundation = const Color(0xFF003253);
  static Color forestFoundation = const Color(0xFF005254);
  static Color wellnessFoundation = const Color(0xFF79b2b6);
  static Color purpleFoundation = const Color(0xFF391463);
  static Color orangeFoundation = const Color(0xFFb5762b);
  static Color leavesFoundation = const Color(0xFF9c803d);
}
