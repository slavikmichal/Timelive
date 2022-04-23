import 'package:flutter/material.dart';
import 'package:timeline_tile/timeline_tile.dart';
import 'package:timelive/themes/color_schemer.dart';

class LinePainter extends CustomPainter {
  final double height;

  LinePainter(this.height);

  @override
  void paint(Canvas canvas, Size size) {
    final centerAxis = size.width / 2;
    final beginTopLine = Offset(centerAxis, 0);
    final beforeLinePaint = Paint()
      ..color = ColorSchemer.vismaBlack.withOpacity(0.7)
      ..strokeWidth = 4;
    final endTopLine = Offset(centerAxis, height);
    canvas.drawLine(beginTopLine, endTopLine, beforeLinePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
