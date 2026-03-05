import 'package:flutter/material.dart';

class NeckPainter extends CustomPainter {
  Color color;
  Size canvasSize = Size.zero;

  NeckPainter(this.color);

  Size getSize() {
    return canvasSize;
  }

  Offset xy(double xp, double yp, Size size) {
    return Offset(xp * size.width / 100.0, yp * size.height / 100.0);
  }

  List getLines() {
    List<Map<String, double>> lines = [];
    int i;

    for (i = 0; i < 8; i++) {
      lines.add({'x1': 15, 'y1': 20 + i * 10, 'x2': 85, 'y2': 20 + i * 10});
      lines.add({'x1': 15, 'y1': 20.3 + i * 10, 'x2': 85, 'y2': 20.3 + i * 10});
    }

    for (i = 0; i < 6; i++) {
      lines.add({'x1': 15 + i * 14, 'y1': 20, 'x2': 15 + i * 14, 'y2': 90.3});
    }

    return lines;
  }

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1.0
      ..strokeCap = StrokeCap.round;

    canvasSize = size;

    for (Map map in getLines()) {
      canvas.drawLine(
        xy(map['x1'], map['y1'], size),
        xy(map['x2'], map['y2'], size),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
