import 'package:flutter/material.dart';
import '../components/appbar_component.dart';
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
    return Scaffold(
      appBar: AppbarComponent(title: 'Chords'),
      drawer: DrawerComponent(),
      body: SafeArea(child: Stack(children: [NeckComponent(scale: 1.0)])),
    );
  }
}
