import 'package:flutter/material.dart';

class Sun extends StatelessWidget {
  const Sun({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.white,
            blurRadius: 5,
            spreadRadius: 4,
          ),
        ],
        shape: BoxShape.circle,
        color: Colors.white,
      ),
    );
  }
}
