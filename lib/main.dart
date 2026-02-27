import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'pages/main_page.dart';
import 'providers/theme_provider.dart';

void main() {
  /* load and set theme */
  ThemeProvider themeProvider = ThemeProvider();
  themeProvider.setLightTheme();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<ThemeProvider>(
          create: (context) => themeProvider,
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
