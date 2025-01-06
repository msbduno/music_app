import 'package:flutter/cupertino.dart';

class AppTheme {
  // Light theme colors
  static const Color lightPrimaryColor = Color(0xFFB4EDD2); // Mint green from the image
  static const Color lightBackgroundColor = Color(0xFFF5F5F5);
  static const Color lightTextColor = Color(0xFF2C2C2C);

  // Dark theme colors
  static const Color darkPrimaryColor = Color(0xFF8BC9AC); // Darker mint green
  static const Color darkBackgroundColor = Color(0xFF2C2C2C); // Dark gray from the image
  static const Color darkTextColor = Color(0xFFF5F5F5);

  static CupertinoThemeData getLightTheme() {
    return CupertinoThemeData(
      brightness: Brightness.light,
      primaryColor: lightPrimaryColor,
      scaffoldBackgroundColor: lightBackgroundColor,
      textTheme: CupertinoTextThemeData(
        primaryColor: lightPrimaryColor,
        textStyle: TextStyle(
          color: lightTextColor,
          fontSize: 16,
        ),
      ),
    );
  }

  static CupertinoThemeData getDarkTheme() {
    return CupertinoThemeData(
      brightness: Brightness.dark,
      primaryColor: darkPrimaryColor,
      scaffoldBackgroundColor: darkBackgroundColor,
      textTheme: CupertinoTextThemeData(
        primaryColor: darkPrimaryColor,
        textStyle: TextStyle(
          color: darkTextColor,
          fontSize: 16,
        ),
      ),
    );
  }

  static CupertinoThemeData getTheme(Brightness brightness) {
    return brightness == Brightness.light ? getLightTheme() : getDarkTheme();
  }
}