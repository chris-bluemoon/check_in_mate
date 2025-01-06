import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData lightTheme(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double titleFontSize = width * 0.05;
    double bodyFontSize = width * 0.04;
    double subtitleFontSize = width * 0.035;

    const myTealColor = Color(0xFF008080);

    return ThemeData(
      primaryColor: myTealColor,
      colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.orange),
      canvasColor: Colors.white,
      scaffoldBackgroundColor: myTealColor,
      appBarTheme: AppBarTheme(
        color: myTealColor,
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
        bodyMedium: TextStyle(color: Colors.white, fontSize: subtitleFontSize),
        headlineSmall: TextStyle(color: Colors.white, fontSize: titleFontSize, fontWeight: FontWeight.bold),
      ),
      buttonTheme: const ButtonThemeData(
        buttonColor: myTealColor,
        textTheme: ButtonTextTheme.primary,
      ),
      inputDecorationTheme: InputDecorationTheme(
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(100),
          borderSide: const BorderSide(color: Colors.white),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(100),
          borderSide: const BorderSide(color: Colors.white),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(100),
          borderSide: const BorderSide(color: Colors.white),
        ),
        filled: true,
        fillColor: Colors.teal[900],
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: const Color(0xFF006666),
        selectedItemColor: Colors.white,
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
        color: myTealColor,
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: myTealColor,
        foregroundColor: Colors.white,
      ),
      checkboxTheme: CheckboxThemeData(
        fillColor: WidgetStateProperty.all(myTealColor),
        checkColor: WidgetStateProperty.all(Colors.white),
        side: const BorderSide(color: Colors.white), 
        overlayColor: WidgetStateProperty.all(Colors.white.withOpacity(0.1)),
      ),
    );
  }

  static ThemeData darkTheme(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double titleFontSize = width * 0.05;
    double bodyFontSize = width * 0.04;
    double subtitleFontSize = width * 0.035;

    const myTealColor = Color(0xFF008080);
    
    return ThemeData(
      primaryColor: myTealColor,
      colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.orange),
      canvasColor: Colors.black,
      scaffoldBackgroundColor: myTealColor, // Teal background for dark theme
      appBarTheme: AppBarTheme(
        color: myTealColor,
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
        buttonColor: myTealColor,
        textTheme: ButtonTextTheme.primary,
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: myTealColor),
        ),
        filled: true,
        fillColor: Colors.grey[800],
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: Colors.black,
        selectedItemColor: myTealColor,
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
        color: myTealColor,
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: myTealColor,
        foregroundColor: Colors.white,
      ),
    );
  }
}