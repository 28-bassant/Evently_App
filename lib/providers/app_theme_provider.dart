import 'package:evently_app/utils/shared_prefs.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppThemeProvider extends ChangeNotifier{
  ThemeMode appTheme = ThemeMode.light;

  void changeTheme(ThemeMode newTheme) async {
    if(appTheme == newTheme){
      return;
    }
    appTheme = newTheme;
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(SharedPrefsKeys.themeKey, newTheme.name);
    notifyListeners();
  }

  Future<void> getTheme() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? theme = prefs.getString(SharedPrefsKeys.themeKey);
    if (theme != null && theme.isNotEmpty) {
      if (theme == 'dark') {
        appTheme = ThemeMode.dark;
      } else if (theme == 'light') {
        appTheme = ThemeMode.light;
      } else {
        appTheme = ThemeMode.system;
      }
      notifyListeners();
    }
  }
  bool iSDark(){
    return appTheme == ThemeMode.dark;
  }

}