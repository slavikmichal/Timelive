import 'package:flutter/material.dart';
import 'package:timelive/timeline_screen.dart';

class TimeliveApp extends StatelessWidget {
  const TimeliveApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Timelive',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const TimelineScreen(),
    );
  }
}
