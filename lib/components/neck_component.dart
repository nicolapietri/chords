import 'package:chords/components/diagram_component.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../painters/neck_painter.dart';
import '../providers/diagram_provider.dart';

class NeckComponent extends StatelessWidget {
  const NeckComponent({super.key, required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    DiagramProvider diagram = Provider.of<DiagramProvider>(
      context,
      listen: false,
    );
    double margin = 20 * scale;
    double width = MediaQuery.sizeOf(context).width * scale;
    double height = MediaQuery.sizeOf(context).height * scale;

    return Container(
      width: width - margin * 2,
      height: height - margin * 2,
      margin: EdgeInsets.all(margin),
      child: Consumer<DiagramProvider>(
        builder: (context, model, widget) => Stack(
          children: [
            GestureDetector(
              child: CustomPaint(
                painter: NeckPainter(width - margin * 2, height - margin * 2),
                size: Size.infinite,
              ),
              onTapDown: (details) {
                diagram.addBulletAtOffset(
                  details.localPosition,
                  width - margin * 2,
                  height - margin * 2,
                );
              },
            ),
            DiagramComponent(
              width: width - margin * 2,
              height: height - margin * 2,
            ),
          ],
        ),
      ),
    );
  }
}
