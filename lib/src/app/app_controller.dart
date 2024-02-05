// app_controller.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppController extends ChangeNotifier {
  bool isDarkTheme = false;

  ThemeData get themeData => isDarkTheme
      ? ThemeData.dark().copyWith(
          textTheme: GoogleFonts.robotoTextTheme(
            ThemeData.dark().textTheme,
          ),
        )
      : ThemeData(
          primarySwatch: Colors.purple,
        ).copyWith(
          textTheme: GoogleFonts.robotoTextTheme(
            ThemeData.light().textTheme,
          ),
        );

  void toggleTheme() {
    isDarkTheme = !isDarkTheme;
    notifyListeners();
  }
}
