import 'package:flutter/material.dart';

import 'lucky_colors.dart';
import 'lucky_tokens.dart';

class LuckyTheme {
  
  static const Color primaryColor = blue;
  static const Color secondaryColor = secondaryBlue;
  static const Color accentColor = accentBlue;
  static const Color errorColor = red;

  static ThemeData lightTheme() {
    final ColorScheme lightScheme = ColorScheme.fromSeed(
      seedColor: primaryColor,
      brightness: Brightness.light,
    ).copyWith(
      primary: primaryColor,
      secondary: secondaryColor,
      error: errorColor,
      surface: white,
      onSurface: black,
      surfaceContainerHighest: gray200,
      onSurfaceVariant: gray600,
    );

    return ThemeData(
      useMaterial3: false,
      colorScheme: lightScheme,
      textSelectionTheme: _textSelectionTheme,
      extensions: const [LuckyColors.light],
      // AppBar theme
      appBarTheme: AppBarThemeData(
        backgroundColor: lightScheme.surface,
        foregroundColor: lightScheme.onSurface,
        elevation: 0,
        centerTitle: false,
        iconTheme: IconThemeData(color: lightScheme.onSurface),
        titleTextStyle: TextStyle(
          color: lightScheme.onSurface,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
      ),
      // Navigation bar theme
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: lightScheme.surface,
        indicatorColor: lightScheme.primary,
        surfaceTintColor: Colors.transparent,
      ),
      // Bottom navigation bar theme
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: lightScheme.surface,
        selectedItemColor: lightScheme.primary,
        unselectedItemColor: lightScheme.onSurfaceVariant,
      ),
    );
  }

  static ThemeData darkTheme() {
    final ColorScheme darkScheme = ColorScheme.fromSeed(
      seedColor: primaryColor,
      brightness: Brightness.dark,
    ).copyWith(
      primary: primaryColor,
      secondary: secondaryColor,
      error: errorColor,
      surface: black,
      onSurface: white,
      surfaceContainerHighest: gray800,
      onSurfaceVariant: gray400,
    );

    return ThemeData(
      useMaterial3: false,
      colorScheme: darkScheme,
      textSelectionTheme: _textSelectionTheme,
      extensions: const [LuckyColors.dark],
      // AppBar theme
      appBarTheme: AppBarThemeData(
        backgroundColor: darkScheme.surface,
        foregroundColor: darkScheme.onSurface,
        elevation: 0,
        centerTitle: false,
        iconTheme: IconThemeData(color: darkScheme.onSurface),
        titleTextStyle: TextStyle(
          color: darkScheme.onSurface,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
      ),
      // Navigation bar theme
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: darkScheme.surface,
        indicatorColor: darkScheme.primary,
        surfaceTintColor: Colors.transparent,
      ),
      // Bottom navigation bar theme
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: darkScheme.surface,
        selectedItemColor: darkScheme.primary,
        unselectedItemColor: darkScheme.onSurfaceVariant,
      ),
    );
  }

  static const TextSelectionThemeData _textSelectionTheme = TextSelectionThemeData(
    selectionColor: blue300,
    selectionHandleColor: primaryColor,
    cursorColor: primaryColor,
  );
}