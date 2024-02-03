import 'package:flutter/material.dart';

class AppController extends ChangeNotifier {
  bool isDarkTheme = false;

  ThemeData get themeData => isDarkTheme
      ? ThemeData.dark()
      : ThemeData(
          primarySwatch: Colors.purple,
        );

  void toggleTheme() {
    isDarkTheme = !isDarkTheme;
    notifyListeners();
  }
}
