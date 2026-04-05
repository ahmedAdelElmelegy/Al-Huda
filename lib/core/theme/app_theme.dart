import 'package:al_huda/core/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTheme {
  static const String fontUI = 'CairoMedium';
  static const String fontUIBold = 'CairoBold';
  static const String fontUISemiBold = 'CairoSemiBold';
  static const String fontUIRegular = 'CairoRegular';
  static const String fontUILight = 'CairoLight';
  static const String fontQuran = 'UthmanicHafs1';
  static const String fontArabic = 'AmiriBold';

  // ─── Light Theme ──────────────────────────────────────────────────────
  static ThemeData light() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      primaryColor: ColorManager.primary,
      scaffoldBackgroundColor: ColorManager.background,
      fontFamily: fontUI,
      colorScheme: const ColorScheme(
        brightness: Brightness.light,
        primary: ColorManager.primary,
        onPrimary: ColorManager.onPrimary,
        secondary: ColorManager.accent,
        onSecondary: Colors.white,
        surface: ColorManager.surface,
        onSurface: ColorManager.textHigh,
        error: ColorManager.error,
        onError: Colors.white,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: ColorManager.primary,
        elevation: 0,
        centerTitle: true,
        scrolledUnderElevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        titleTextStyle: TextStyle(
          fontFamily: fontUISemiBold,
          fontSize: 18.sp,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
        systemOverlayStyle: SystemUiOverlayStyle.light,
      ),
      cardTheme: CardThemeData(
        color: ColorManager.surface,
        elevation: 2,
        shadowColor: Colors.black.withValues(alpha: 0.08),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        margin: EdgeInsets.zero,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: ColorManager.primary,
          foregroundColor: ColorManager.onPrimary,
          elevation: 0,
          minimumSize: const Size(double.infinity, 48),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: TextStyle(
            fontFamily: fontUISemiBold,
            fontSize: 15.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: ColorManager.primary,
          textStyle: TextStyle(
            fontFamily: fontUISemiBold,
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: ColorManager.surface,
        selectedItemColor: ColorManager.primary,
        unselectedItemColor: ColorManager.textLight,
        type: BottomNavigationBarType.fixed,
        elevation: 0,
        showUnselectedLabels: true,
        selectedLabelStyle: TextStyle(
          fontFamily: fontUISemiBold,
          fontSize: 11.sp,
        ),
        unselectedLabelStyle: TextStyle(
          fontFamily: fontUIRegular,
          fontSize: 11.sp,
        ),
      ),
      dividerTheme: const DividerThemeData(
        color: Color(0xFFE8F0ED),
        thickness: 1,
        space: 0,
      ),
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return ColorManager.primary;
          }
          return ColorManager.gray;
        }),
        trackColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return ColorManager.accent.withValues(alpha: 0.4);
          }
          return ColorManager.greyLight;
        }),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: ColorManager.surfaceAlt,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: ColorManager.primary, width: 1.5),
        ),
        hintStyle: TextStyle(
          color: ColorManager.textLight,
          fontFamily: fontUIRegular,
          fontSize: 14.sp,
        ),
      ),
      textTheme: _buildTextTheme(isLight: true),
    );
  }

  // ─── Dark Theme ───────────────────────────────────────────────────────
  static ThemeData dark() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      primaryColor: ColorManager.primaryDark,
      scaffoldBackgroundColor: ColorManager.backgroundDark,
      fontFamily: fontUI,
      colorScheme: const ColorScheme(
        brightness: Brightness.dark,
        primary: ColorManager.primaryDark,
        onPrimary: Colors.black,
        secondary: ColorManager.accent,
        onSecondary: Colors.black,
        surface: ColorManager.surfaceDark,
        onSurface: ColorManager.textHighDark,
        error: ColorManager.error,
        onError: Colors.black,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: ColorManager.surfaceDark,
        elevation: 0,
        centerTitle: true,
        scrolledUnderElevation: 0,
        iconTheme: const IconThemeData(color: ColorManager.textHighDark),
        titleTextStyle: TextStyle(
          fontFamily: fontUISemiBold,
          fontSize: 18.sp,
          color: ColorManager.textHighDark,
        ),
        systemOverlayStyle: SystemUiOverlayStyle.light,
      ),
      cardTheme: CardThemeData(
        color: ColorManager.surfaceDark,
        elevation: 2,
        shadowColor: Colors.black.withValues(alpha: 0.3),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        margin: EdgeInsets.zero,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: ColorManager.primaryDark,
          foregroundColor: Colors.black,
          elevation: 0,
          minimumSize: const Size(double.infinity, 48),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: TextStyle(fontFamily: fontUISemiBold, fontSize: 15.sp),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: ColorManager.primaryDark,
          textStyle: TextStyle(fontFamily: fontUISemiBold, fontSize: 14.sp),
        ),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: ColorManager.surfaceDark,
        selectedItemColor: ColorManager.primaryDark,
        unselectedItemColor: ColorManager.textMediumDark,
        type: BottomNavigationBarType.fixed,
        elevation: 0,
        showUnselectedLabels: true,
        selectedLabelStyle: TextStyle(
          fontFamily: fontUISemiBold,
          fontSize: 11.sp,
        ),
        unselectedLabelStyle: TextStyle(
          fontFamily: fontUIRegular,
          fontSize: 11.sp,
        ),
      ),
      dividerTheme: const DividerThemeData(
        color: Color(0xFF253B32),
        thickness: 1,
        space: 0,
      ),
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return ColorManager.primaryDark;
          }
          return ColorManager.textLight;
        }),
        trackColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return ColorManager.accent.withValues(alpha: 0.4);
          }
          return ColorManager.surfaceAltDark;
        }),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: ColorManager.surfaceAltDark,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(
            color: ColorManager.primaryDark,
            width: 1.5,
          ),
        ),
        hintStyle: TextStyle(
          color: ColorManager.textMediumDark,
          fontFamily: fontUIRegular,
          fontSize: 14.sp,
        ),
      ),
      textTheme: _buildTextTheme(isLight: false),
    );
  }

  static TextTheme _buildTextTheme({required bool isLight}) {
    final Color high = isLight
        ? ColorManager.textHigh
        : ColorManager.textHighDark;
    final Color medium = isLight
        ? ColorManager.textMedium
        : ColorManager.textMediumDark;
    final Color light = ColorManager.textLight;

    return TextTheme(
      // Quran / decorative display
      displayLarge: TextStyle(
        fontFamily: fontArabic,
        fontSize: 32.sp,
        fontWeight: FontWeight.bold,
        color: high,
        height: 1.8,
      ),
      // Screen hero numbers (countdown)
      displayMedium: TextStyle(
        fontFamily: fontUIBold,
        fontSize: 42.sp,
        fontWeight: FontWeight.w700,
        color: Colors.white,
        letterSpacing: 2,
      ),
      // Section headings
      headlineMedium: TextStyle(
        fontFamily: fontUISemiBold,
        fontSize: 20.sp,
        fontWeight: FontWeight.w600,
        color: high,
      ),
      // Card titles
      titleLarge: TextStyle(
        fontFamily: fontUISemiBold,
        fontSize: 16.sp,
        fontWeight: FontWeight.w600,
        color: high,
      ),
      titleMedium: TextStyle(
        fontFamily: fontUI,
        fontSize: 14.sp,
        fontWeight: FontWeight.w500,
        color: high,
      ),
      // Body copy
      bodyLarge: TextStyle(
        fontFamily: fontUIRegular,
        fontSize: 15.sp,
        color: high,
        height: 1.6,
      ),
      bodyMedium: TextStyle(
        fontFamily: fontUIRegular,
        fontSize: 13.sp,
        color: medium,
        height: 1.5,
      ),
      // Labels / badges
      labelLarge: TextStyle(
        fontFamily: fontUISemiBold,
        fontSize: 13.sp,
        fontWeight: FontWeight.w600,
        color: high,
      ),
      bodySmall: TextStyle(
        fontFamily: fontUIRegular,
        fontSize: 11.sp,
        color: light,
      ),
      labelSmall: TextStyle(
        fontFamily: fontUIRegular,
        fontSize: 10.sp,
        color: light,
      ),
    );
  }
}
