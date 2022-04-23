import 'package:flutter/material.dart';
import 'package:timelive/timeline_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

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

