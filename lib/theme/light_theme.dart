import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
  colorScheme: ColorScheme.light(
    brightness: Brightness.light,
    primary: Colors.orange.shade900,
    onPrimary: Colors.white,
    secondary: Colors.blue.shade800,
    onSecondary: Colors.black,
    surface: const Color.fromARGB(255, 240, 240, 240),
    onSurface: Colors.grey.shade800,
    surfaceContainer: Colors.grey.shade100,
    shadow: Colors.grey.shade500,
    outline: const Color.fromARGB(255, 200, 200, 200),
    tertiary: Colors.green.shade600,
  ),
);
