import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
  colorScheme: ColorScheme.light(
    brightness: Brightness.light,
    primary: Colors.brown.shade700,
    onPrimary: Colors.white,
    secondary: const Color.fromARGB(255, 215, 140, 40),
    onSecondary: Colors.black,
    surface: const Color.fromARGB(255, 230, 230, 230),
    onSurface: Colors.grey.shade800,
    surfaceContainer: Colors.grey.shade100,
    shadow: Colors.grey.shade500,
    outline: const Color.fromARGB(255, 200, 200, 200),
    tertiary: Colors.green.shade600,
  ),
);
