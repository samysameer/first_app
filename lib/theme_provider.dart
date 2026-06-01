import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

final ValueNotifier<ThemeMode> appThemeModeNotifier = ValueNotifier(
  ThemeMode.light, // Default until we load the saved preference
);

class ThemeProvider {
  static const String _key = 'isDarkMode';

  /// Load saved theme from disk. Call this before runApp().
  static Future<void> loadSavedTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final isDark = prefs.getBool(_key) ?? false;
    appThemeModeNotifier.value = isDark ? ThemeMode.dark : ThemeMode.light;
  }

  /// Toggle and persist the theme.
  static Future<void> toggleTheme() async {
    final isDark = appThemeModeNotifier.value == ThemeMode.dark;
    appThemeModeNotifier.value = isDark ? ThemeMode.light : ThemeMode.dark;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_key, !isDark);
  }
}
