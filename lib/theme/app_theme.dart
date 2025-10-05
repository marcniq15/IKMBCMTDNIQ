import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // --- 1. Color Palette ---
  static const Color primaryColor = Color(0xFF2C3E50);
  static const Color secondaryColor = Color(0xFF3498DB);
  static const Color accentColor = Color(0xFFFD7A2E);

  // Light Mode Colors
  static const Color lightBackgroundColor = Color(0xFFF4F6F8);
  static const Color lightSurfaceColor = Colors.white;

  // NEW: Dark Mode Colors
  static const Color darkBackgroundColor = Color(0xFF1C1C1E); // A very dark grey, almost black
  static const Color darkSurfaceColor = Color(0xFF2C2C2E);  // A slightly lighter grey for cards

  // --- 2. Light Text Theme ---
  static final TextTheme _lightTextTheme = TextTheme(
    displayLarge: GoogleFonts.poppins(fontSize: 28, fontWeight: FontWeight.bold, color: primaryColor),
    headlineMedium: GoogleFonts.poppins(fontSize: 22, fontWeight: FontWeight.bold, color: primaryColor),
    titleLarge: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87),
    bodyLarge: GoogleFonts.poppins(fontSize: 16, color: Colors.black87),
    bodyMedium: GoogleFonts.poppins(fontSize: 14, color: Colors.black54),
    labelLarge: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold),
  );

  // --- 3. NEW: Dark Text Theme ---
  // We define how text should look in dark mode (mostly white/light grey).
  static final TextTheme _darkTextTheme = TextTheme(
    displayLarge: GoogleFonts.poppins(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white),
    headlineMedium: GoogleFonts.poppins(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
    titleLarge: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
    bodyLarge: GoogleFonts.poppins(fontSize: 16, color: Colors.white70),
    bodyMedium: GoogleFonts.poppins(fontSize: 14, color: Colors.white54),
    labelLarge: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
  );

  // --- 4. The Light Theme Definition ---
  static ThemeData get lightTheme {
    return ThemeData(
      brightness: Brightness.light,
      primaryColor: primaryColor,
      scaffoldBackgroundColor: lightBackgroundColor,
      colorScheme: const ColorScheme.light(
        primary: primaryColor,
        secondary: secondaryColor,
        surface: lightSurfaceColor,
        background: lightBackgroundColor,
      ),
      textTheme: _lightTextTheme,
      // We will define component themes directly inside the ThemeData
      // to avoid inheriting them incorrectly in the dark theme.
      appBarTheme: AppBarTheme(
        backgroundColor: primaryColor,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        titleTextStyle: GoogleFonts.poppins(
          color: Colors.white,
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  // --- 5. NEW: The Dark Theme Definition ---
  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      primaryColor: primaryColor,
      scaffoldBackgroundColor: darkBackgroundColor,
      colorScheme: const ColorScheme.dark(
        primary: primaryColor,
        secondary: secondaryColor,
        surface: darkSurfaceColor, // Used for cards
        background: darkBackgroundColor,
      ),
      textTheme: _darkTextTheme,
      appBarTheme: AppBarTheme(
        // Use a slightly lighter color for app bars in dark mode for a nice contrast
        backgroundColor: darkSurfaceColor,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        titleTextStyle: GoogleFonts.poppins(
          color: Colors.white,
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
        ),
      ),
      // Define dark theme for other components as needed
      cardTheme: const CardThemeData(
        color: darkSurfaceColor,
      ),
    );
  }
}