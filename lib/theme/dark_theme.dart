import 'package:flutter/material.dart';

//primary: Colors.blue.shade300,
//onPrimary: Colors.black,

ThemeData darkTheme = ThemeData(
  colorScheme: ColorScheme.dark(
    brightness: Brightness.light,
    primary: Colors.brown.shade700,
    onPrimary: Colors.white,
    secondary: Colors.yellow.shade800,
    onSecondary: Colors.black,
    surface: Colors.grey.shade900,
    onSurface: Colors.white,
    surfaceContainer: const Color.fromARGB(255, 48, 48, 48),
    shadow: Colors.black,
    outline: Colors.grey.shade700,
    tertiary: Colors.green.shade300,
  ),
);
