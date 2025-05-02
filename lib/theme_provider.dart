import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider with ChangeNotifier {
  static const String _themeKey = 'isDarkMode';
  bool _isDarkMode = false;
  SharedPreferences? _prefs;

  ThemeProvider() {
    _loadTheme();
  }

  bool get isDarkMode => _isDarkMode;

  ThemeData get currentTheme => _isDarkMode ? darkTheme : lightTheme;

  Future<void> _loadTheme() async {
    try {
      _prefs = await SharedPreferences.getInstance();
      _isDarkMode = _prefs?.getBool(_themeKey) ?? false;
      notifyListeners();
    } catch (e) {
      debugPrint('Error loading theme: $e');
    }
  }

  Future<void> toggleTheme() async {
    try {
      _isDarkMode = !_isDarkMode;
      await _prefs?.setBool(_themeKey, _isDarkMode);
      notifyListeners();
      debugPrint('Theme toggled to: ${_isDarkMode ? 'dark' : 'light'}');
    } catch (e) {
      debugPrint('Error toggling theme: $e');
      // Revert the change if saving fails
      _isDarkMode = !_isDarkMode;
      notifyListeners();
    }
  }

  ThemeData get darkTheme => ThemeData.dark().copyWith(
    scaffoldBackgroundColor: const Color(0xFF101520),
    primaryColor: const Color(0xFF4AEDC4),
    colorScheme: const ColorScheme.dark(
      primary: Color(0xFF4AEDC4),
      secondary: Color(0xFF4AEDC4),
      surface: Color(0xFF1E2B3D),
      error: Colors.red,
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onSurface: Colors.white,
      onError: Colors.white,
    ),
    cardColor: const Color(0xFF1E2B3D),
    textTheme: const TextTheme(
      displayLarge: TextStyle(
        color: Colors.white,
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
      bodyLarge: TextStyle(
        color: Colors.white,
        fontSize: 16,
      ),
      bodyMedium: TextStyle(
        color: Colors.white70,
        fontSize: 14,
      ),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF101520),
      elevation: 0,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF4AEDC4),
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    ),
  );

  ThemeData get lightTheme => ThemeData.light().copyWith(
    scaffoldBackgroundColor: Colors.white,
    primaryColor: const Color(0xFF4AEDC4),
    colorScheme: const ColorScheme.light(
      primary: Color(0xFF4AEDC4),
      secondary: Color(0xFF4AEDC4),
      surface: Colors.white,
      error: Colors.red,
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onSurface: Colors.black,
      onError: Colors.white,
    ),
    cardColor: Colors.white,
    textTheme: const TextTheme(
      displayLarge: TextStyle(
        color: Colors.black,
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
      bodyLarge: TextStyle(
        color: Colors.black,
        fontSize: 16,
      ),
      bodyMedium: TextStyle(
        color: Colors.black87,
        fontSize: 14,
      ),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      elevation: 0,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF4AEDC4),
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    ),
  );
} 