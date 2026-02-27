import 'package:flutter/material.dart';
import '../painters/neck_painter.dart';

class NeckComponent extends StatelessWidget {
  NeckComponent({super.key, required this.scale});

  double scale = 1.0;

  @override
  Widget build(BuildContext context) {
    double margin = 20 * scale;
    double width = MediaQuery.sizeOf(context).width * scale;
    double height = MediaQuery.sizeOf(context).height * scale;

    return Container(
      color: Colors.blueGrey,
      width: width - margin * 2,
      height: height - margin * 2,
      margin: EdgeInsets.all(margin),
      child: CustomPaint(
        painter: NeckPainter(width - margin * 2, height - margin * 2),
        size: Size.infinite,
      ),
    );
  }
}
