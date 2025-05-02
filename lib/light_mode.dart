import 'package:flutter/material.dart';

class LightTheme {
  // Main Colors
  static const Color backgroundColor = Colors.white; // Pure white
  static const Color surfaceColor = Colors.white; // Pure white
  static const Color cardBackground = Colors.white; // White for cards
  static const Color inputBackground = Colors.white; // White for input fields

  // Text Colors
  static const Color primaryTextColor = Color(0xFF2D3142);
  static const Color secondaryTextColor = Color(0xFF9A9A9A);
  static const Color linkColor = Color(0xFF20C997); // Teal for links
  static const Color inputTextColor = Color(0xFF495057); // Input text color

  // Input Fields
  static const Color inputBorderColor = Color(0xFFE0E0E0);

  // Buttons
  static const Color buttonStartColor = Color(0xFF4AEDC4);
  static const Color buttonEndColor = Color(0xFF4AEDC4);
  static const Color buttonTextColor = Colors.white; // White
  static const Color buttonShadowColor = Color(0x1A4AEDC4);

  // Icons
  static const Color iconGlowColor = Color(0xFFD1F2EB); // Soft teal glow
  static const Color iconBackgroundColor = Color(0xFFF5F5F5);
  static const Color iconColor = Color(0xFF20C997); // Teal icon color

  // Additional Colors for Other Screens
  static const Color textScreenBackground = Color(0xFFFFFFFF); // White for text screen
  static const Color voiceScreenBackground = Color(0xFFFFFFFF); // White for voice screen
  static const Color imageScreenBackground = Color(0xFFFFFFFF); // White for image screen
  static const Color resultScreenBackground = Color(0xFFFFFFFF); // White for result screen
  static const Color resultCardBackground = Color(0xFFFFFFFF); // White for result cards

  static ThemeData get theme {
    return ThemeData(
      primaryColor: buttonStartColor,
      colorScheme: const ColorScheme.light(
        primary: buttonStartColor,
        secondary: buttonEndColor,
        surface: surfaceColor,
        error: Color(0xFFDC3545),
        onPrimary: buttonTextColor,
        onSecondary: buttonTextColor,
        onSurface: primaryTextColor,
        onError: buttonTextColor,
      ),
      scaffoldBackgroundColor: backgroundColor,
      textTheme: const TextTheme(
        headlineMedium: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: primaryTextColor,
        ),
        bodyMedium: TextStyle(
          fontSize: 16,
          color: primaryTextColor,
        ),
        labelLarge: TextStyle(
          color: primaryTextColor,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
        titleMedium: TextStyle(
          color: primaryTextColor,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
        bodySmall: TextStyle(
          color: secondaryTextColor,
          fontSize: 14,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: inputBackground,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: inputBorderColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: inputBorderColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: buttonStartColor, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFFDC3545), width: 2),
        ),
        labelStyle: const TextStyle(color: inputTextColor),
        hintStyle: const TextStyle(color: inputTextColor),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: buttonStartColor,
          foregroundColor: buttonTextColor,
          elevation: 4,
          shadowColor: buttonShadowColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        ),
      ),
      cardTheme: CardTheme(
        color: cardBackground,
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: inputBorderColor),
        ),
        shadowColor: buttonShadowColor,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: primaryTextColor),
        titleTextStyle: TextStyle(
          color: primaryTextColor,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      iconTheme: const IconThemeData(
        color: iconColor,
      ),
      dividerTheme: const DividerThemeData(
        color: inputBorderColor,
        thickness: 1,
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: surfaceColor,
        selectedItemColor: buttonStartColor,
        unselectedItemColor: secondaryTextColor,
      ),
    );
  }
} 