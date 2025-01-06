import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData lightTheme(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double titleFontSize = width * 0.05;
    double bodyFontSize = width * 0.04;
    double subtitleFontSize = width * 0.035;

    return ThemeData(
      primaryColor: Colors.teal,
      colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.orange),
      canvasColor: Colors.white,
      scaffoldBackgroundColor: Colors.teal, // Teal background
      appBarTheme: AppBarTheme(
        color: Colors.teal,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        toolbarTextStyle: TextTheme(
          titleLarge: TextStyle(
            color: Colors.white,
            fontSize: titleFontSize,
            fontWeight: FontWeight.bold,
          ),
        ).bodyLarge,
        titleTextStyle: TextTheme(
          titleLarge: TextStyle(
            color: Colors.white,
            fontSize: titleFontSize,
            fontWeight: FontWeight.bold,
          ),
        ).titleLarge,
      ),
      textTheme: TextTheme(
        bodyLarge: TextStyle(color: Colors.black, fontSize: bodyFontSize),
        bodyMedium: TextStyle(color: Colors.black54, fontSize: subtitleFontSize),
        headlineSmall: TextStyle(color: Colors.black, fontSize: titleFontSize, fontWeight: FontWeight.bold),
      ),
      buttonTheme: const ButtonThemeData(
        buttonColor: Colors.teal,
        textTheme: ButtonTextTheme.primary,
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Colors.teal),
        ),
        filled: true,
        fillColor: Colors.grey[200],
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: Colors.white,
        selectedItemColor: Colors.teal,
        unselectedItemColor: Colors.grey,
        selectedLabelStyle: TextStyle(fontSize: subtitleFontSize),
        unselectedLabelStyle: TextStyle(fontSize: subtitleFontSize),
      ),
      cardTheme: CardTheme(
        color: Colors.white,
        shadowColor: Colors.grey.withOpacity(0.5),
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      iconTheme: const IconThemeData(
        color: Colors.teal,
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),
    );
  }

  static ThemeData darkTheme(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double titleFontSize = width * 0.05;
    double bodyFontSize = width * 0.04;
    double subtitleFontSize = width * 0.035;

    return ThemeData(
      primaryColor: Colors.teal,
      colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.orange),
      canvasColor: Colors.black,
      scaffoldBackgroundColor: Colors.teal, // Teal background for dark theme
      appBarTheme: AppBarTheme(
        color: Colors.teal,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        toolbarTextStyle: TextTheme(
          titleLarge: TextStyle(
            color: Colors.white,
            fontSize: titleFontSize,
            fontWeight: FontWeight.bold,
          ),
        ).bodyLarge,
        titleTextStyle: TextTheme(
          titleLarge: TextStyle(
            color: Colors.white,
            fontSize: titleFontSize,
            fontWeight: FontWeight.bold,
          ),
        ).titleLarge,
      ),
      textTheme: TextTheme(
        bodyLarge: TextStyle(color: Colors.white, fontSize: bodyFontSize),
        bodyMedium: TextStyle(color: Colors.white70, fontSize: subtitleFontSize),
        titleLarge: TextStyle(color: Colors.white, fontSize: titleFontSize, fontWeight: FontWeight.bold),
      ),
      buttonTheme: const ButtonThemeData(
        buttonColor: Colors.teal,
        textTheme: ButtonTextTheme.primary,
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Colors.teal),
        ),
        filled: true,
        fillColor: Colors.grey[800],
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: Colors.black,
        selectedItemColor: Colors.teal,
        unselectedItemColor: Colors.grey,
        selectedLabelStyle: TextStyle(fontSize: subtitleFontSize),
        unselectedLabelStyle: TextStyle(fontSize: subtitleFontSize),
      ),
      cardTheme: CardTheme(
        color: Colors.grey[900],
        shadowColor: Colors.black.withOpacity(0.5),
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      iconTheme: const IconThemeData(
        color: Colors.teal,
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),
    );
  }
}