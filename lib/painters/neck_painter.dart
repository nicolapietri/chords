import 'package:flutter/material.dart';

class NeckPainter extends CustomPainter {
  double width;
  double height;

  NeckPainter(this.width, this.height);

  Offset xy(double xp, double yp) {
    return Offset(xp * width / 100.0, yp * height / 100.0);
  }

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 1.0
      ..strokeCap = StrokeCap.round;
    Offset startOffset = xy(0, 0);
    Offset endOffset = xy(50, 50);
    canvas.drawLine(startOffset, endOffset, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
