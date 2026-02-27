import 'package:flutter/material.dart';

class CardComponent extends StatelessWidget {
  final Widget? child;

  const CardComponent({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 8, right: 8, top: 8, bottom: 8),
      child: Container(
        padding: EdgeInsets.only(top: 8, bottom: 8, left: 16, right: 16),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surfaceContainer,
          borderRadius: BorderRadius.circular(6),

          boxShadow: [
            BoxShadow(
              blurRadius: 6,
              spreadRadius: -6,
              color: Theme.of(context).colorScheme.shadow,
              offset: const Offset(4, 4),
            ),
          ],
        ),
        child: child,
      ),
    );
  }
}
