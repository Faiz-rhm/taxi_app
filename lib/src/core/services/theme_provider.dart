import 'package:flutter/material.dart';
import 'app_theme.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.light;
  
  ThemeMode get themeMode => _themeMode;
  
  bool get isDarkMode => _themeMode == ThemeMode.dark;
  bool get isLightMode => _themeMode == ThemeMode.light;
  
  void setThemeMode(ThemeMode themeMode) {
    if (_themeMode == themeMode) return;
    
    _themeMode = themeMode;
    notifyListeners();
  }
  
  void toggleTheme() {
    final newThemeMode = _themeMode == ThemeMode.light 
        ? ThemeMode.dark 
        : ThemeMode.light;
    setThemeMode(newThemeMode);
  }
  
  ThemeData getLightTheme() => AppTheme.lightTheme;
  ThemeData getDarkTheme() => AppTheme.darkTheme;
}
