import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/diagram_provider.dart';

class DiagramComponent extends StatelessWidget {
  final Size size;
  final double ratio = 1.4;

  /* units */
  final int left = 3;
  final int top = 4;
  final int frets = 7;
  final double fontSize = 21;

  const DiagramComponent({super.key, required this.size});

  double dx() => size.width / 16;
  double dy() => dx() * ratio;
  double radius() => dx() * 0.9;

  double px(int x) {
    return x * dx();
  }

  double py(int y) {
    return y * dy();
  }

  @override
  Widget build(BuildContext context) {
    DiagramProvider diagram = Provider.of<DiagramProvider>(
      context,
      listen: false,
    );

    List<String> allIntervals = diagram.getAllIntervals();
    String chordName =
        diagram.root.toUpperCase() +
        diagram.tuning.getChordNameFromIntervals(allIntervals);

    return Stack(
      children: [
        Positioned(
          left: px(1),
          top: py(top),
          child: Text(
            diagram.tuning.capo > 0 ? "${diagram.tuning.capo + 1}" : "",
            style: TextStyle(fontSize: fontSize * 0.9),
          ),
        ),
        /* draw fretboard */
        for (int block = 1; block <= 5; block++)
          for (int fret = 1; fret <= frets; fret++)
            Positioned(
              left: px(left + (block - 1) * 2),
              top: py(top + (fret - 1) * 2),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
                child: SizedBox(width: px(2) - 1, height: py(2) - 3),
              ),
            ),
        /* draw normal bullets */
        ...diagram.items.where((bullet) => bullet.fret > 0).map((e) {
          var fillColor = e.root
              ? Colors.red.shade900
              : (e.filled ? Colors.black87 : Colors.white);
          var borderColor = (e.filled || e.root) ? fillColor : Colors.black87;
          double borderWidth = 4;
          var textColor = (e.filled || e.root) ? Colors.white : Colors.black87;

          /* special for filled dots in dark mode */
          if (Theme.of(context).colorScheme.brightness == Brightness.dark) {
            borderColor = Colors.white;
            borderWidth = 1;
          }

          /* bullet render */
          return Positioned(
            left:
                px(left + 9 - (e.string - 1) * 2) + (px(2) - radius() * 2) / 2,
            top: py(top + (e.fret - 1) * 2) + (py(2) - radius() * 2) / 2,
            child: GestureDetector(
              child: Container(
                width: radius() * 2,
                height: radius() * 2,
                decoration: BoxDecoration(
                  color: fillColor,
                  border: BoxBorder.all(color: borderColor, width: borderWidth),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    e.text,
                    style: TextStyle(
                      fontSize: e.text.length > 2 ? fontSize - 1 : fontSize,
                      color: textColor,
                    ),
                  ),
                ),
              ),
              onTap: () => diagram.rotateBulletAlternative(e),
            ),
          );
        }),
        /* draw capo bullets */
        ...diagram.items
            .where((bullet) => bullet.fret == 0 && diagram.tuning.capo == 0)
            .map((e) {
              return Positioned(
                left:
                    px(left + 9 - (e.string - 1) * 2) +
                    (px(2) - radius() * 1.5) / 2,
                top: py(top + (e.fret - 1) * 2) + (py(2) - radius() * 2) * 1.3,
                child: GestureDetector(
                  child: Icon(
                    e.alternative == 0 ? Icons.circle_outlined : Icons.close,
                    color: Theme.of(context).colorScheme.onSurface,
                    size: radius() * 1.5,
                  ),
                  onTap: () => diagram.rotateBulletAlternative(e),
                ),
              );
            }),
        /* clickable grid */
        for (int string = 1; string <= 6; string++)
          for (int fret = 0; fret <= frets; fret++)
            Positioned(
              left: px(left + 9 - (string - 1) * 2),
              top: py(top + (fret - 1) * 2),
              child: GestureDetector(
                child: Container(
                  color: Colors.transparent,
                  width: px(2) - 1,
                  height: py(2) - 3,
                ),
                onTap: () => diagram.addBulletAtFret(string, fret),
              ),
            ),
        /* intervals list */
        Positioned(
          left: px(left),
          top: py(top + frets * 2 + 1),
          child: SizedBox(
            width: px(10),
            child: Center(
              child: Text(
                allIntervals.isEmpty
                    ? ''
                    : allIntervals.reduce((a, b) => "$a $b"),
                style: TextStyle(
                  fontSize: fontSize * 0.9,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
        Positioned(
          left: px(left),
          top: py(1),
          child: SizedBox(
            width: px(10),
            child: Center(
              child: Text(
                chordName,
                style: TextStyle(
                  fontSize: fontSize * 1.5,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
