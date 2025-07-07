import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsKeys {
  static const String languageKey = 'language_key';
  static const String themeKey = 'theme_key';
}

void SaveNewLanguage(String newLanguage) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString(SharedPrefsKeys.languageKey, newLanguage);
}

void SaveNewTheme(ThemeMode newTheme) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString(SharedPrefsKeys.themeKey, newTheme.name);
}
