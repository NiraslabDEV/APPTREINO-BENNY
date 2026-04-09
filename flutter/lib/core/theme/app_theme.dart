import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Paleta extraída do DESIGN.md (HTML gerado pelo Stitch)
class KineticColors {
  KineticColors._();

  // Primárias
  static const Color primary = Color(0xFFF5FFC5);
  static const Color primaryContainer = Color(0xFFD4FB00);
  static const Color primaryDim = Color(0xFFC9EF00);
  static const Color onPrimary = Color(0xFF556600);
  static const Color onPrimaryContainer = Color(0xFF4D5D00);

  // Secundárias
  static const Color secondary = Color(0xFF00E3FD);
  static const Color secondaryContainer = Color(0xFF006875);
  static const Color secondaryDim = Color(0xFF00D4EC);
  static const Color onSecondary = Color(0xFF004D57);

  // Superfícies
  static const Color background = Color(0xFF0E0E0E);
  static const Color surface = Color(0xFF0E0E0E);
  static const Color surfaceContainer = Color(0xFF1A1A1A);
  static const Color surfaceContainerLow = Color(0xFF131313);
  static const Color surfaceContainerHigh = Color(0xFF20201F);
  static const Color surfaceContainerHighest = Color(0xFF262626);
  static const Color surfaceBright = Color(0xFF2C2C2C);

  // Texto
  static const Color onSurface = Color(0xFFFFFFFF);
  static const Color onSurfaceVariant = Color(0xFFADAAAA);
  static const Color onBackground = Color(0xFFFFFFFF);

  // Outline
  static const Color outline = Color(0xFF767575);
  static const Color outlineVariant = Color(0xFF484847);

  // Error
  static const Color error = Color(0xFFFF7351);
  static const Color errorContainer = Color(0xFFB92902);

  // Terciárias (usado para PRs, medals)
  static const Color tertiary = Color(0xFFFFEBA0);
  static const Color tertiaryContainer = Color(0xFFFDDB42);
}

class AppTheme {
  AppTheme._();

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: KineticColors.background,
      colorScheme: const ColorScheme.dark(
        primary: KineticColors.primary,
        primaryContainer: KineticColors.primaryContainer,
        onPrimary: KineticColors.onPrimary,
        onPrimaryContainer: KineticColors.onPrimaryContainer,
        secondary: KineticColors.secondary,
        secondaryContainer: KineticColors.secondaryContainer,
        onSecondary: KineticColors.onSecondary,
        surface: KineticColors.surface,
        onSurface: KineticColors.onSurface,
        error: KineticColors.error,
        errorContainer: KineticColors.errorContainer,
        outline: KineticColors.outline,
        outlineVariant: KineticColors.outlineVariant,
      ),
      textTheme: TextTheme(
        // Headlines — Lexend (bold/black italic)
        displayLarge: GoogleFonts.lexend(
          fontSize: 48,
          fontWeight: FontWeight.w900,
          color: KineticColors.onSurface,
          fontStyle: FontStyle.italic,
        ),
        displayMedium: GoogleFonts.lexend(
          fontSize: 36,
          fontWeight: FontWeight.w900,
          color: KineticColors.onSurface,
          fontStyle: FontStyle.italic,
        ),
        headlineLarge: GoogleFonts.lexend(
          fontSize: 28,
          fontWeight: FontWeight.w800,
          color: KineticColors.onSurface,
        ),
        headlineMedium: GoogleFonts.lexend(
          fontSize: 22,
          fontWeight: FontWeight.w700,
          color: KineticColors.onSurface,
        ),
        // Body — Inter
        bodyLarge: GoogleFonts.inter(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: KineticColors.onSurface,
        ),
        bodyMedium: GoogleFonts.inter(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: KineticColors.onSurfaceVariant,
        ),
        labelLarge: GoogleFonts.inter(
          fontSize: 12,
          fontWeight: FontWeight.w700,
          letterSpacing: 1.5,
          color: KineticColors.onSurfaceVariant,
        ),
        labelMedium: GoogleFonts.inter(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          letterSpacing: 1.2,
          color: KineticColors.onSurfaceVariant,
        ),
      ),
      // Botões principais com estilo KINETIC
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: KineticColors.primaryContainer,
          foregroundColor: KineticColors.onPrimary,
          shape: const StadiumBorder(),
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          textStyle: GoogleFonts.lexend(
            fontSize: 16,
            fontWeight: FontWeight.w900,
            letterSpacing: 0.5,
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: KineticColors.surfaceContainerLow,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: KineticColors.outlineVariant),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: KineticColors.outlineVariant),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide:
              const BorderSide(color: KineticColors.primaryContainer, width: 2),
        ),
        labelStyle: GoogleFonts.inter(color: KineticColors.onSurfaceVariant),
        hintStyle: GoogleFonts.inter(color: KineticColors.outlineVariant),
      ),
      cardTheme: CardTheme(
        color: KineticColors.surfaceContainer,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 0,
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: KineticColors.surfaceContainerLow,
        selectedItemColor: KineticColors.primaryContainer,
        unselectedItemColor: KineticColors.onSurfaceVariant,
        type: BottomNavigationBarType.fixed,
        elevation: 0,
      ),
    );
  }
}
