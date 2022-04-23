import 'package:flutter/material.dart';
import 'package:timelive/themes/color_schemer.dart';

class IconIndicator extends StatelessWidget {
  const IconIndicator({
    required this.iconData,
    required this.size,
    Key? key,
  }) : super(key: key);

  final IconData iconData;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: ColorSchemer.indicatorShadowColor,
          ),
        ),
        Positioned.fill(
          child: Align(
            alignment: Alignment.center,
            child: SizedBox(
              height: 30,
              width: 30,
              child: Icon(
                iconData,
                size: size,
                color: ColorSchemer.iconIndicatorColor,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
