import 'package:flutter/material.dart';

abstract class ColorManager {
  // ─── Primary Brand ───────────────────────────────────────────────────
  static const Color primary = Color(0xFF1B6B5A);
  static const Color accent = Color(0xFF2DA882);
  static const Color primaryLight = Color(0xFF4A9B83);
  static const Color primaryDark = Color(0xFF3FBB94); // lighter in dark mode

  // ─── Backgrounds (Light) ─────────────────────────────────────────────
  static const Color background = Color(0xFFF5FAF8);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceAlt = Color(0xFFECF6F1);
  static const Color primaryBg = Color(0xFFE8F5EF);

  // ─── Backgrounds (Dark) ──────────────────────────────────────────────
  static const Color backgroundDark = Color(0xFF0F1F1A);
  static const Color surfaceDark = Color(0xFF1A2E27);
  static const Color surfaceAltDark = Color(0xFF243B32);

  // ─── Text ────────────────────────────────────────────────────────────
  static const Color textHigh = Color(0xFF1E2C28);
  static const Color textMedium = Color(0xFF4A6359);
  static const Color textLight = Color(0xFF8AADA3);
  static const Color textHighDark = Color(0xFFECF6F1);
  static const Color textMediumDark = Color(0xFF9DC4B8);

  // ─── Legacy aliases (keep existing code compiling) ───────────────────
  static const Color primary2 = primary;
  static const Color primaryText = accent;
  static const Color primaryText2 = textMedium;
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF1E1E1E);
  static const Color gray = Color(0xFFA1A1A1);
  static const Color greyLight = Color(0xFFF5F5F5);
  static const Color greyLight2 = Color(0xFFEEEEEE);
  static const Color grayMoreLight = Color(0xFFF9F9F9);
  static const Color blue = Color(0xFF1B6180);
  static const Color red = Color(0xFFE62D2D);

  // ─── Semantic ────────────────────────────────────────────────────────
  static const Color error = Color(0xFFD32F2F);
  static const Color success = Color(0xFF2E7D32);
  static const Color gold = Color(0xFFD4A017);
  static const Color onPrimary = Color(0xFFFFFFFF);
}
