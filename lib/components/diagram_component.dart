import 'package:flutter/material.dart';
import 'dart:math';
import 'package:provider/provider.dart';
import '../providers/diagram_provider.dart';

class DiagramComponent extends StatelessWidget {
  final Size size;

  const DiagramComponent({super.key, required this.size});

  Offset xy(double xp, double yp, Size size) {
    return Offset(xp * size.width / 100.0, yp * size.height / 100.0);
  }

  @override
  Widget build(BuildContext context) {
    double radius = min(xy(13, 0, size).dx, xy(0, 13, size).dy);
    double fontSize = 22;

    DiagramProvider diagram = Provider.of<DiagramProvider>(
      context,
      listen: false,
    );

    return Stack(
      children: [
        Positioned(
          left: xy(7, 19, size).dx,
          top: xy(7, 19, size).dy,
          child: Text(
            diagram.tuning.capo > 0 ? "${diagram.tuning.capo + 1}" : "",
            style: TextStyle(fontSize: fontSize * 0.9),
          ),
        ),
        ...diagram.items.map((e) {
          double left =
              xy(15 + 14 * 6 - 14 * e.string.toDouble(), 0, size).dx -
              radius / 2;
          double top =
              xy(0, 20 - 5 + 10 * e.fret.toDouble(), size).dy - radius / 2;
          var fillColor = e.root
              ? Colors.red.shade900
              : (e.filled ? Colors.black87 : Colors.white);
          var borderColor = e.filled ? fillColor : Colors.black87;
          double borderWidth = 4;
          var textColor = e.filled ? Colors.white : Colors.black87;

          /* bullet render */
          return Positioned(
            left: left,
            top: top,
            child: GestureDetector(
              child: Container(
                width: radius,
                height: radius,
                decoration: BoxDecoration(
                  color: fillColor,
                  border: BoxBorder.all(color: borderColor, width: borderWidth),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    e.text,
                    style: TextStyle(fontSize: fontSize, color: textColor),
                  ),
                ),
              ),
              onTap: () => diagram.rotateBulletAlternative(e),
            ),
          );
        }),
      ],
    );
  }
}
