import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'AppPreferences.dart';
class ThemeProvider with ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.light;
  ThemeMode get themeMode => _themeMode;

  ThemeProvider() {
    _loadTheme();
  }

  Future<void> _loadTheme() async {

    final savedMode = AppPreferences.themeMode;
    
    if (savedMode == 'dark') {
      _themeMode = ThemeMode.dark;
    } else if (savedMode == 'light') {
      _themeMode = ThemeMode.light;
    } else {
      _themeMode = ThemeMode.system;
    }
    notifyListeners();
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    _themeMode = mode;
    String modeString = mode.toString().split('.')[1];
    await AppPreferences.setThemeMode(modeString);
    notifyListeners();
  }


}