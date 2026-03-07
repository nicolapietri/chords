import 'package:flutter/material.dart';

class FretboardComponent extends StatelessWidget {
  final Size size;

  const FretboardComponent({super.key, required this.size});

  Offset xy(double xp, double yp, Size size) {
    return Offset(xp * size.width / 100.0, yp * size.height / 100.0);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: []);
  }
}
