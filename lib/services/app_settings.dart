import 'package:flutter/material.dart';
import 'package:innotes/main.dart';

class AppSettingsService extends ChangeNotifier {
  ThemeMode get themeMode => _loadThemeMode();
  set themeMode(ThemeMode newThemeMode) {
    globaleSharedPreferencesInstance.setInt("theme-mode", newThemeMode.index);
    notifyListeners();
  }

  ThemeMode _loadThemeMode() {
    final modeIndex =
        globaleSharedPreferencesInstance.getInt("theme-mode") ?? 0;
    return ThemeMode.values[modeIndex];
  }
}
