import 'package:flutter/material.dart';

//primary: Colors.blue.shade300,
//onPrimary: Colors.black,

ThemeData darkTheme = ThemeData(
  colorScheme: ColorScheme.dark(
    brightness: Brightness.dark,
    primary: Colors.orange.shade900,
    onPrimary: Colors.black,
    secondary: Colors.blue.shade200,
    onSecondary: Colors.white,
    surface: const Color.fromARGB(255, 40, 40, 40),
    onSurface: Colors.grey.shade200,
    surfaceContainer: Colors.grey.shade100,
    shadow: Colors.grey.shade500,
    outline: const Color.fromARGB(255, 60, 60, 60),
    tertiary: Colors.green.shade200,
  ),
);
