import 'package:flutter/material.dart';
import '../components/appbar_component.dart';
import '../components/bottom_appbar_component.dart';
import '../components/drawer_component.dart';
import '../components/neck_component.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    AppbarComponent appBar = AppbarComponent(title: 'Chords');
    BottomAppBarComponent bottomAppBar = BottomAppBarComponent();
    double scale = 1.0;
    double baseFontSize = 21 * scale;
    double safeWidth = MediaQuery.sizeOf(context).width * scale;
    double safeHeight =
        (MediaQuery.sizeOf(context).height -
            appBar.preferredSize.height -
            kBottomNavigationBarHeight) *
        scale;

    return Scaffold(
      appBar: appBar,
      drawer: DrawerComponent(),
      body: SafeArea(
        child: Center(
          child: NeckComponent(
            size: Size(safeWidth, safeHeight),
            baseFontSize: baseFontSize,
          ),
        ),
      ),
      bottomNavigationBar: bottomAppBar,
    );
  }
}
