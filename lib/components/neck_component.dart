import 'package:chords/components/diagram_component.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../painters/neck_painter.dart';
import '../providers/diagram_provider.dart';

class NeckComponent extends StatelessWidget {
  const NeckComponent({super.key, required this.size});

  final Size size;

  @override
  Widget build(BuildContext context) {
    DiagramProvider diagram = Provider.of<DiagramProvider>(
      context,
      listen: false,
    );

    return SizedBox(
      width: size.width,
      height: size.height,
      child: Consumer<DiagramProvider>(
        builder: (context, model, widget) => Stack(
          children: [
            GestureDetector(
              child: CustomPaint(
                painter: NeckPainter(Theme.of(context).colorScheme.onSurface),
                size: size,
              ),

              onTapDown: (details) {
                diagram.addBulletAtOffset(
                  details.localPosition,
                  size.width,
                  size.height - kBottomNavigationBarHeight,
                );
              },
            ),
            DiagramComponent(
              size: Size(
                size.width,
                size.height - kBottomNavigationBarHeight - 11,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
