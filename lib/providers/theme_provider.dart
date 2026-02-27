import 'package:flutter/material.dart';
import 'package:chords/theme/dark_theme.dart';
import 'package:chords/theme/light_theme.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeData _themeData = lightTheme;

  ThemeData get themeData => _themeData;
  bool get isDarkMode => _themeData == darkTheme;

  void setLightTheme() {
    _themeData = lightTheme;
    notifyListeners();
  }

  void setDarkTheme() {
    _themeData = darkTheme;
    notifyListeners();
  }

  void toggleTheme() {
    if (_themeData == darkTheme) {
      setLightTheme();
    } else {
      setDarkTheme();
    }
  }
}
