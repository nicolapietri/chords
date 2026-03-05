import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/diagram_provider.dart';

class BottomAppBarComponent extends StatelessWidget {
  const BottomAppBarComponent({super.key});

  @override
  Widget build(BuildContext context) {
    DiagramProvider diagram = Provider.of<DiagramProvider>(
      context,
      listen: false,
    );

    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      color: Theme.of(context).colorScheme.primary,
      notchMargin: 5.0,
      clipBehavior: Clip.antiAlias,
      child: SizedBox(
        height: kBottomNavigationBarHeight,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.cameraswitch),
              padding: EdgeInsets.all(0),
              color: Theme.of(context).colorScheme.onPrimary,
              onPressed: () {
                diagram.toggleRelative();
              },
            ),

            IconButton(
              icon: const Icon(Icons.my_location),
              color: Theme.of(context).colorScheme.onPrimary,
              onPressed: () {
                diagram.nextIsRoot();
              },
            ),
            IconButton(
              icon: const Icon(Icons.move_down),
              color: Theme.of(context).colorScheme.onPrimary,
              onPressed: () {
                diagram.moveCapoDown();
              },
            ),
            IconButton(
              icon: const Icon(Icons.delete),
              color: Theme.of(context).colorScheme.onPrimary,
              onPressed: () {
                diagram.reset();
              },
            ),
          ],
        ),
      ),
    );
  }
}
