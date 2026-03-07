import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/diagram_provider.dart';
import 'fretboard_component.dart';
import 'diagram_component.dart';

class NeckComponent extends StatelessWidget {
  const NeckComponent({super.key, required this.size});

  final Size size;

  @override
  Widget build(BuildContext context) {
    Size canvasSize = Size(
      size.width,
      size.height - kBottomNavigationBarHeight - 11,
    );

    return SizedBox(
      width: size.width,
      height: size.height,
      child: Consumer<DiagramProvider>(
        builder: (context, model, widget) => Stack(
          children: [
            FretboardComponent(
              size: canvasSize,
              /*onTap: (position) {
                diagram.addBulletAtOffset(
                  position,
                  size.width,
                  size.height - kBottomNavigationBarHeight,
                );
              },*/
            ),
            DiagramComponent(size: canvasSize),
          ],
        ),
      ),
    );
  }
}
