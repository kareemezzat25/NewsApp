import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode thememode = ThemeMode.light;

  changeTheme() {
    if (thememode == ThemeMode.light) {
      thememode = ThemeMode.dark;
    } else {
      thememode = ThemeMode.light;
    }
    notifyListeners();
  }
}
