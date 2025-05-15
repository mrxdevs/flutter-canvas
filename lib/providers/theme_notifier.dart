import 'package:flutter/material.dart';
import 'package:flutter_canvas/themes/app_themes.dart';

enum ThemeModeType { light, dark }

class ThemeNotifier extends ChangeNotifier {
  ThemeData _currentTheme = AppThemes.darkTheme; // Default to dark theme
  ThemeModeType _currentThemeMode = ThemeModeType.dark;

  ThemeData get currentTheme => _currentTheme;
  ThemeModeType get currentThemeMode => _currentThemeMode;

  bool get isDarkMode => _currentThemeMode == ThemeModeType.dark;

  void toggleTheme() {
    if (_currentThemeMode == ThemeModeType.light) {
      _currentTheme = AppThemes.darkTheme;
      _currentThemeMode = ThemeModeType.dark;
    } else {
      _currentTheme = AppThemes.lightTheme;
      _currentThemeMode = ThemeModeType.light;
    }
    notifyListeners();
  }

  // Optional: Method to set a specific theme
  void setTheme(ThemeModeType themeMode) {
    if (themeMode == ThemeModeType.light) {
      _currentTheme = AppThemes.lightTheme;
      _currentThemeMode = ThemeModeType.light;
    } else {
      _currentTheme = AppThemes.darkTheme;
      _currentThemeMode = ThemeModeType.dark;
    }
    notifyListeners();
  }
}
