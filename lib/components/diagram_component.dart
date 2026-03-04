import 'package:flutter/material.dart';
import 'dart:math';
import 'package:provider/provider.dart';
import '../providers/diagram_provider.dart';

class DiagramComponent extends StatelessWidget {
  final double width;
  final double height;

  const DiagramComponent({
    super.key,
    required this.width,
    required this.height,
  });

  Offset xy(double xp, double yp) {
    return Offset(xp * width / 100.0, yp * height / 100.0);
  }

  @override
  Widget build(BuildContext context) {
    double radius = min(xy(12, 0).dx, xy(0, 12).dy);
    double fontSize = 26;

    DiagramProvider diagram = Provider.of<DiagramProvider>(
      context,
      listen: false,
    );

    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Stack(
        children: [
          diagram.tuning.capo == 0
              ? SizedBox(width: 0)
              : Positioned(
                  left: xy(7, 19).dx,
                  top: xy(7, 19).dy,
                  child: Text(
                    "${diagram.tuning.capo + 1}",
                    style: TextStyle(fontSize: fontSize * 2 / 3),
                  ),
                ),
          ...diagram.items.map((e) {
            double left =
                xy(15 + 14 * 6 - 14 * e.string.toDouble(), 0).dx - radius / 2;
            double top = xy(0, 20 - 5 + 10 * e.fret.toDouble()).dy - radius / 2;
            var fillColor = e.root
                ? Colors.red.shade900
                : (e.filled ? Colors.black87 : Colors.white);
            var borderColor = e.filled ? fillColor : Colors.black87;
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
                    border: BoxBorder.all(color: borderColor, width: 4),
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
          }).toList(),
        ],
      ),
    );
  }
}
