import 'package:flutter/material.dart';
import 'package:innotes/constants/colors.dart';

abstract class ThemeConsts {
  static ThemeData buildLightThemeData() {
    const primaryColor = Colors.blueGrey;
    final hintColor = primaryColor.shade200;
    const backroundColor = Colors.white;
    final ColorScheme colorScheme = ColorScheme.fromSeed(
      seedColor: primaryColor,
      brightness: Brightness.light,
      primary: primaryColor,
      background: backroundColor,
    );
    return ThemeData.light(useMaterial3: true).copyWith(
      colorScheme: colorScheme,
      primaryColor: primaryColor,
      hintColor: hintColor,
      cardColor: primaryColor.shade50,
      adaptations: [const Adaptation<NotesCardColorsLight>()],
      textTheme: buildTextTheme(primaryColor),
      scaffoldBackgroundColor: backroundColor,
      dialogTheme: const DialogTheme(
          surfaceTintColor: backroundColor, backgroundColor: backroundColor),
      bottomSheetTheme: builBottomSheetThemeData(backroundColor),
      dividerTheme: DividerThemeData(color: hintColor, thickness: .5),
      inputDecorationTheme:
          buildInputDecorationThemeData(primaryColor, hintColor),
      iconTheme: const IconThemeData(color: primaryColor),
      textButtonTheme: builTextButtonTheme(),
      floatingActionButtonTheme: buildfloatingActionButtonTheme(primaryColor),
    );
  }

  static ThemeData buildDarkThemeData() {
    const primaryColor = Colors.white;
    final hintColor = Colors.blueGrey.shade200;
    final backroundColor = Colors.blueGrey.shade800;
    final ColorScheme colorScheme = ColorScheme.fromSeed(
      seedColor: primaryColor,
      brightness: Brightness.dark,
      primary: primaryColor,
      background: backroundColor,
    );
    return ThemeData.light(useMaterial3: true).copyWith(
      colorScheme: colorScheme,
      primaryColor: primaryColor,
      hintColor: hintColor,
      cardColor: Colors.blueGrey.shade600,
      adaptations: [const Adaptation<NotesCardColorsLight>()],
      textTheme: buildTextTheme(primaryColor),
      scaffoldBackgroundColor: backroundColor,
      dialogTheme: DialogTheme(
          surfaceTintColor: backroundColor, backgroundColor: backroundColor),
      bottomSheetTheme: builBottomSheetThemeData(backroundColor),
      dividerTheme: DividerThemeData(color: hintColor, thickness: .5),
      inputDecorationTheme:
          buildInputDecorationThemeData(primaryColor, hintColor),
      iconTheme: const IconThemeData(color: primaryColor),
      textButtonTheme: builTextButtonTheme(),
      floatingActionButtonTheme: buildfloatingActionButtonTheme(primaryColor),
    );
  }

  static InputDecorationTheme buildInputDecorationThemeData(
      Color primaryColor, Color hintColor) {
    final textStyle = buildTextTheme(primaryColor).bodySmall;
    return InputDecorationTheme(
      fillColor: primaryColor.withOpacity(.2),
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
        borderSide: BorderSide(width: 2, color: primaryColor),
      ),
      hintStyle: textStyle.copyWith(height: 1, color: hintColor),
    );
  }

  static BottomSheetThemeData builBottomSheetThemeData(Color bgColor) {
    return BottomSheetThemeData(
      backgroundColor: bgColor,
      surfaceTintColor: bgColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
    );
  }

  static FloatingActionButtonThemeData buildfloatingActionButtonTheme(
      Color primaryColor) {
    return FloatingActionButtonThemeData(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      elevation: 0,
      backgroundColor: primaryColor,
    );
  }

  static TextTheme buildTextTheme(Color primaryColor) {
    return TextTheme(
      headlineLarge: TextStyle(
        fontFamily: 'Poppins',
        color: primaryColor,
        fontSize: 50,
      ),
      headlineMedium: TextStyle(
        fontFamily: 'Poppins',
        color: primaryColor,
        fontSize: 43,
      ),
      headlineSmall: TextStyle(
        fontFamily: 'Poppins',
        color: primaryColor,
        fontSize: 36,
      ),
      titleLarge: TextStyle(
        fontFamily: 'Poppins',
        color: primaryColor,
        fontSize: 30,
      ),
      titleMedium: TextStyle(
        fontFamily: 'Poppins',
        color: primaryColor,
        fontSize: 26.5,
      ),
      titleSmall: TextStyle(
        fontFamily: 'Poppins',
        color: primaryColor,
        fontSize: 23,
      ),
      bodyLarge: TextStyle(
        fontFamily: 'Poppins',
        color: primaryColor,
        fontSize: 20,
      ),
      bodyMedium: TextStyle(
        fontFamily: 'Poppins',
        color: primaryColor,
        fontSize: 16,
      ),
      bodySmall: TextStyle(
        fontFamily: 'Poppins',
        color: primaryColor,
        fontSize: 14,
      ),
      displayLarge: TextStyle(
        fontFamily: 'Poppins',
        color: primaryColor,
        fontSize: 11,
      ),
      displayMedium: TextStyle(
        fontFamily: 'Poppins',
        color: primaryColor,
        fontSize: 9,
      ),
    );
  }

  static TextButtonThemeData builTextButtonTheme() {
    return TextButtonThemeData(
      style: ButtonStyle(
        shape: MaterialStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}
