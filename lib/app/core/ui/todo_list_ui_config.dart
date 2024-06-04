import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TodoListUiConfig {
  TodoListUiConfig._();

  static ThemeData get theme => ThemeData(
        textTheme: GoogleFonts.mandaliTextTheme().copyWith(
          displayLarge: const TextStyle(
            color: Colors.black,
            fontSize: 57,
            fontWeight: FontWeight.bold,
          ),
          displayMedium: const TextStyle(
            color: Colors.black,
            fontSize: 45,
            fontWeight: FontWeight.bold,
          ),
          displaySmall: const TextStyle(
            color: Colors.black,
            fontSize: 36,
            fontWeight: FontWeight.bold,
          ),
          headlineLarge: const TextStyle(
            color: Colors.black,
            fontSize: 32,
            fontWeight: FontWeight.bold,
          ),
          headlineMedium: const TextStyle(
            color: Colors.black,
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
          headlineSmall: const TextStyle(
            color: Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
          titleLarge: const TextStyle(
            color: Colors.black,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
          titleMedium: const TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.w500,
            letterSpacing: 0.15,
          ),
          titleSmall: const TextStyle(
            color: Colors.black,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
          bodyLarge: const TextStyle(
            color: Colors.black,
            fontSize: 16,
          ),
          bodyMedium: const TextStyle(
            color: Colors.black,
            fontSize: 14,
          ),
          bodySmall: const TextStyle(
            color: Colors.black,
            fontSize: 12,
          ),
          labelLarge: const TextStyle(
            color: Colors.black,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
          labelMedium: const TextStyle(
            color: Colors.black,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
          labelSmall: const TextStyle(
            color: Colors.black,
            fontSize: 11,
            fontWeight: FontWeight.w500,
            letterSpacing: 0.5,
          ),
        ),
        primaryColor: const Color(0xFF5C77CE),
        primaryColorLight: const Color(0xFFABC8F7),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF5C77CE),
          ),
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: const Color(0xFF5C77CE),
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
            fontFamily: GoogleFonts.mandali().fontFamily,
          ),
        ),
      );
}
