import 'package:flutter/material.dart';

class ScaffoldMessengerManager {
  static void publish(BuildContext context, Widget content) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: content));
  }
}
