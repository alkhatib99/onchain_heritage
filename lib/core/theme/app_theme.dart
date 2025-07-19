import 'package:flutter/material.dart';

class AppTheme {
  // Enhanced colors based on design recommendations
  static const Color primaryBackground = Color(0xFF0A0A0A); // Deep black background
  static const Color secondaryBackground = Color(0xFF1A1A1A); // Card/container backgrounds
  static const Color primaryAccent = Color(0xFF8B5CF6); // Primary purple accent
  static const Color goldAccent = Color(0xFFF59E0B); // Gold accent for success/premium
  static const Color blueAccent = Color(0xFF3B82F6); // Blue accent for info/secondary
  static const Color successGreen = Color(0xFF10B981); // Success states
  static const Color warningRed = Color(0xFFEF4444); // Error/warning states
  static const Color neutralGray = Color(0xFF374151); // Neutral borders/dividers
  static const Color textFieldBackground = Color(0xFF1F2937); // Input field backgrounds
  static const Color whiteText = Color(0xFFFFFFFF); // Primary text
  static const Color lightGrayText = Color(0xFF9CA3AF); // Secondary text
  
  // Glassmorphism colors
  static const Color glassBackground = Color(0x0DFFFFFF); // 5% white opacity
  static const Color glassBorder = Color(0x1AFFFFFF); // 10% white opacity

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: primaryBackground,
      primaryColor: primaryAccent,
      colorScheme: const ColorScheme.dark(
        primary: primaryAccent,
        secondary: blueAccent,
        surface: secondaryBackground,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onSurface: whiteText,
      ),

      // AppBar Theme
      appBarTheme: const AppBarTheme(
        backgroundColor: primaryBackground,
        foregroundColor: whiteText,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          color: whiteText,
          fontSize: 20,
          fontWeight: FontWeight.bold,
          fontFamily: 'Montserrat',
        ),
      ),

      // Text Theme
      textTheme: const TextTheme(
        headlineLarge: TextStyle(
          color: whiteText,
          fontSize: 24,
          fontWeight: FontWeight.bold,
          fontFamily: 'Montserrat',
        ),
        headlineMedium: TextStyle(
          color: whiteText,
          fontSize: 20,
          fontWeight: FontWeight.bold,
          fontFamily: 'Montserrat',
        ),
        titleLarge: TextStyle(
          color: whiteText,
          fontSize: 16,
          fontWeight: FontWeight.bold,
          fontFamily: 'Montserrat',
        ),
        bodyLarge: TextStyle(
          color: whiteText,
          fontSize: 14,
          fontFamily: 'Montserrat',
        ),
        bodyMedium: TextStyle(
          color: whiteText,
          fontSize: 12,
          fontFamily: 'Montserrat',
        ),
        labelLarge: TextStyle(
          color: whiteText,
          fontSize: 14,
          fontWeight: FontWeight.w500,
          fontFamily: 'Montserrat',
        ),
      ),

      // Input Decoration Theme
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: textFieldBackground,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: primaryAccent, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.red, width: 2),
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        hintStyle: const TextStyle(
          color: Colors.grey,
          fontSize: 14,
          fontFamily: 'Montserrat',
        ),
        labelStyle: const TextStyle(
          color: whiteText,
          fontSize: 14,
          fontWeight: FontWeight.bold,
          fontFamily: 'Montserrat',
        ),
      ),

      // Elevated Button Theme
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryAccent,
          foregroundColor: Colors.white,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            fontFamily: 'Montserrat',
          ),
        ),
      ),

      // Outlined Button Theme
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          backgroundColor: Colors.transparent,
          foregroundColor: primaryAccent,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          side:
              const BorderSide(color: primaryAccent, width: 2),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            fontFamily: 'Montserrat',
          ),
        ),
      ),

      // Text Button Theme
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          backgroundColor: Colors.transparent,
          foregroundColor: lightGrayText,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            fontFamily: 'Montserrat',
          ),
        ),
      ),

      // Dropdown Theme
      dropdownMenuTheme: DropdownMenuThemeData(
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: textFieldBackground,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
        textStyle: const TextStyle(
          color: whiteText,
          fontSize: 14,
          fontFamily: 'Montserrat',
        ),
      ),

      // Card Theme
      cardTheme: CardTheme(
        color: secondaryBackground,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        margin: const EdgeInsets.all(8),
      ),
    );
  }

  // Glassmorphism card decoration
  static BoxDecoration get glassCardDecoration => BoxDecoration(
    color: glassBackground,
    borderRadius: BorderRadius.circular(16),
    border: Border.all(
      color: glassBorder,
      width: 1,
    ),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.1),
        blurRadius: 10,
        offset: const Offset(0, 4),
      ),
    ],
  );

  // Enhanced card decoration for wallet options
  static BoxDecoration get walletCardDecoration => BoxDecoration(
    color: secondaryBackground,
    borderRadius: BorderRadius.circular(16),
    border: Border.all(
      color: neutralGray,
      width: 1,
    ),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.2),
        blurRadius: 8,
        offset: const Offset(0, 2),
      ),
    ],
  );

  // Hover effect for wallet cards
  static BoxDecoration get walletCardHoverDecoration => BoxDecoration(
    color: secondaryBackground,
    borderRadius: BorderRadius.circular(16),
    border: Border.all(
      color: primaryAccent,
      width: 2,
    ),
    boxShadow: [
      BoxShadow(
        color: primaryAccent.withOpacity(0.2),
        blurRadius: 12,
        offset: const Offset(0, 4),
      ),
    ],
  );

  // Custom button styles (updated to reflect new theme)
  static ButtonStyle get primaryButtonStyle => ElevatedButton.styleFrom(
        backgroundColor: primaryAccent,
        foregroundColor: Colors.white,
        elevation: 0,
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        textStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          fontFamily: 'Montserrat',
        ),
      );

  static ButtonStyle get secondaryButtonStyle => OutlinedButton.styleFrom(
        backgroundColor: Colors.transparent,
        foregroundColor: primaryAccent,
        elevation: 0,
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        side: const BorderSide(color: primaryAccent, width: 2),
        textStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          fontFamily: 'Montserrat',
        ),
      );

  static ButtonStyle get neutralButtonStyle => ElevatedButton.styleFrom(
        backgroundColor: neutralGray,
        foregroundColor: Colors.white,
        elevation: 0,
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        textStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          fontFamily: 'Montserrat',
        ),
      );
}


