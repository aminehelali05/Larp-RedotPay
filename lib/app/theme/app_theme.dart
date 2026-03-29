import 'package:flutter/material.dart';

class AppTheme {
  static const _brandRed = Color(0xFFFA2E57);
  static const _bgDark = Color(0xFF000000);
  static const _surfaceDark = Color(0xFF1D1F26);

  static ThemeData get dark {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: _bgDark,
      colorScheme: const ColorScheme.dark(
        primary: _brandRed,
        secondary: _brandRed,
        surface: _surfaceDark,
      ),
      textTheme: const TextTheme(
        headlineLarge: TextStyle(fontSize: 58, fontWeight: FontWeight.w700, height: 1),
        titleLarge: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
        titleMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        bodyLarge: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
        bodyMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
        bodySmall: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Color(0xFF8D8E96)),
      ),
      dividerColor: const Color(0xFF30333A),
      cardColor: _surfaceDark,
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      fontFamilyFallback: const ['Inter', 'SF Pro Text', 'Roboto'],
    );
  }

  static ThemeData get light {
    final base = dark;
    return base.copyWith(
      brightness: Brightness.light,
      scaffoldBackgroundColor: Colors.white,
      colorScheme: const ColorScheme.light(
        primary: _brandRed,
        secondary: _brandRed,
        surface: Color(0xFFF2F3F7),
      ),
      textTheme: base.textTheme.apply(bodyColor: Colors.black87, displayColor: Colors.black87),
      dividerColor: const Color(0xFFE3E4EA),
      cardColor: const Color(0xFFF2F3F7),
    );
  }
}
