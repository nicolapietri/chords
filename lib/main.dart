import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'pages/main_page.dart';
import 'providers/theme_provider.dart';
import 'providers/diagram_provider.dart';

import 'data/tuning.dart';

void main() {
  /* load and set theme */
  ThemeProvider themeProvider = ThemeProvider();
  themeProvider.setLightTheme();
  DiagramProvider diagramProvider = DiagramProvider(tuning: Tuning());
  diagramProvider.majorScale().setRelative(true);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<ThemeProvider>(
          create: (context) => themeProvider,
        ),
        ChangeNotifierProvider<DiagramProvider>(
          create: (context) => diagramProvider,
        ),
      ],
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: Provider.of<ThemeProvider>(context).themeData,
      home: const MainPage(),
    );
  }
}
