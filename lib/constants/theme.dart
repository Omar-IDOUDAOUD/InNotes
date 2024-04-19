import 'package:flutter/material.dart';

abstract class ThemeConsts {
  static ThemeData buildLightThemeData() {
    final primaryColor = Colors.blueGrey.shade800;
    return ThemeData.light(useMaterial3: true).copyWith(
        textTheme: buildTextTheme(ThemeMode.light),
        colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.blueGrey, background: Colors.white),
        scaffoldBackgroundColor: Colors.white,
        cardColor: Colors.blueGrey.shade50,
        primaryColor: primaryColor,
        hintColor: Colors.blueGrey.shade200,
        bottomSheetTheme: builBottomSheetThemeData(ThemeMode.light),
        inputDecorationTheme: buildInputDecorationThemeData(),
        iconTheme: IconThemeData(color: primaryColor),
        appBarTheme: buildAppBarTheme(),
        textButtonTheme: TextButtonThemeData(
            style: ButtonStyle(
                shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10))))),
        floatingActionButtonTheme: buildfloatingActionButtonTheme());
  }

  static AppBarTheme buildAppBarTheme() {
    return AppBarTheme(
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.white,
    );
  }

  static buildInputDecorationThemeData() {
    final textStyle = buildTextTheme(ThemeMode.light).bodySmall;
    return InputDecorationTheme(
      fillColor: Colors.blueGrey.shade100.withOpacity(.5),
      filled: true,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide.none,
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(width: 2, color: Colors.redAccent),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(width: 2, color: Colors.redAccent),
      ),
      errorStyle: textStyle!.copyWith(
        color: Colors.redAccent,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(width: 2, color: Colors.blueGrey.shade500),
      ),
      hintStyle: textStyle.copyWith(
        height: 1,
        color: Colors.blueGrey.shade200,
      ),
    );
  }

  static BottomSheetThemeData builBottomSheetThemeData(ThemeMode themeMode) {
    final bgColor =
        themeMode == ThemeMode.light ? Colors.white : Colors.blueGrey.shade900;
    return BottomSheetThemeData(
      backgroundColor: bgColor,
      surfaceTintColor: bgColor,
      modalBackgroundColor: bgColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
    );
  }

  static ThemeData buildDarkThemeData() {
    return ThemeData.dark(useMaterial3: true).copyWith(
      textTheme: buildTextTheme(ThemeMode.dark),
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueGrey),
      scaffoldBackgroundColor: Colors.blueGrey.shade900,
      primaryColor: Colors.white,
      hintColor: Colors.white.withOpacity(.5),
      bottomSheetTheme: builBottomSheetThemeData(ThemeMode.dark),
      iconTheme: const IconThemeData(color: Colors.white),
    );
  }

  static FloatingActionButtonThemeData buildfloatingActionButtonTheme() {
    return FloatingActionButtonThemeData(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      elevation: 0,
      backgroundColor: Colors.blueGrey,
    );
  }

  static TextTheme buildTextTheme(ThemeMode themeMode) {
    final color = switch (themeMode) {
      ThemeMode.light => Colors.blueGrey.shade900,
      _ => Colors.white,
    };
    return TextTheme(
      titleLarge: TextStyle(
        fontFamily: 'Poppins',
        color: color,
        fontSize: 30,
      ),
      titleMedium: TextStyle(
        fontFamily: 'Poppins',
        color: color,
        fontSize: 26.5,
      ),
      titleSmall: TextStyle(
        fontFamily: 'Poppins',
        color: color,
        fontSize: 23,
      ),
      bodyLarge: TextStyle(
        fontFamily: 'Poppins',
        color: color,
        fontSize: 20,
      ),
      bodyMedium: TextStyle(
        fontFamily: 'Poppins',
        color: color,
        fontSize: 16,
      ),
      bodySmall: TextStyle(
        fontFamily: 'Poppins',
        color: color,
        fontSize: 14,
      ),
      displayLarge: TextStyle(
        fontFamily: 'Poppins',
        color: color,
        fontSize: 11,
      ),
      displayMedium: TextStyle(
        fontFamily: 'Poppins',
        color: color,
        fontSize: 9,
      ),
    );
  }
}
