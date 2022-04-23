import 'package:flutter/material.dart';
import 'package:timelive/themes/color_schemer.dart';
import 'package:timelive/timeline_screen.dart';

class TimeliveApp extends StatelessWidget {
  const TimeliveApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Timelive',
      // themeMode: ThemeMode.system,
      themeMode: ThemeMode.light,
      theme: ColorSchemer.lightTheme(),
      darkTheme: ColorSchemer.darkTheme(),
      home: const TimelineScreen(),
    );
  }
}
