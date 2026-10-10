import 'package:flutter/material.dart';

import 'app_colors.dart';

abstract final class AppTheme {
  static final ThemeData dark = _build(
    const ColorScheme(
      brightness: Brightness.dark,
      primary: AppColors.darkPrimary,
      onPrimary: AppColors.darkOnPrimary,
      primaryContainer: AppColors.darkPrimaryContainer,
      onPrimaryContainer: AppColors.darkOnPrimaryContainer,
      secondary: AppColors.darkSecondary,
      onSecondary: AppColors.darkOnSecondary,
      surface: AppColors.darkSurface,
      onSurface: AppColors.darkOnSurface,
      surfaceContainer: AppColors.darkSurfaceContainer,
      surfaceContainerHigh: AppColors.darkSurfaceContainerHigh,
      onSurfaceVariant: AppColors.darkOnSurfaceVariant,
      outline: AppColors.darkOutline,
      outlineVariant: AppColors.darkOutlineVariant,
      error: AppColors.darkError,
      onError: AppColors.darkOnError,
    ),
  );

  static final ThemeData light = _build(
    const ColorScheme(
      brightness: Brightness.light,
      primary: AppColors.lightPrimary,
      onPrimary: AppColors.lightOnPrimary,
      primaryContainer: AppColors.lightPrimaryContainer,
      onPrimaryContainer: AppColors.lightOnPrimaryContainer,
      secondary: AppColors.lightSecondary,
      onSecondary: AppColors.lightOnSecondary,
      surface: AppColors.lightSurface,
      onSurface: AppColors.lightOnSurface,
      surfaceContainer: AppColors.lightSurfaceContainer,
      surfaceContainerHigh: AppColors.lightSurfaceContainerHigh,
      onSurfaceVariant: AppColors.lightOnSurfaceVariant,
      outline: AppColors.lightOutline,
      outlineVariant: AppColors.lightOutlineVariant,
      error: AppColors.lightError,
      onError: AppColors.lightOnError,
    ),
  );

  static const _textTheme = TextTheme(
    headlineLarge: TextStyle(
      fontSize: 32,
      height: 38 / 32,
      fontWeight: FontWeight.w700,
      letterSpacing: -0.8,
    ),
    titleLarge: TextStyle(
      fontSize: 22,
      height: 28 / 22,
      fontWeight: FontWeight.w600,
      letterSpacing: -0.3,
    ),
    titleMedium: TextStyle(
      fontSize: 18,
      height: 24 / 18,
      fontWeight: FontWeight.w600,
    ),
    titleSmall: TextStyle(
      fontSize: 16,
      height: 22 / 16,
      fontWeight: FontWeight.w600,
    ),
    bodyLarge: TextStyle(fontSize: 16, height: 24 / 16),
    bodyMedium: TextStyle(fontSize: 14, height: 21 / 14),
    bodySmall: TextStyle(fontSize: 12, height: 18 / 12),
    labelLarge: TextStyle(
      fontSize: 14,
      height: 18 / 14,
      fontWeight: FontWeight.w600,
    ),
    labelMedium: TextStyle(
      fontSize: 12,
      height: 16 / 12,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.4,
      fontFeatures: [FontFeature.tabularFigures()],
    ),
    labelSmall: TextStyle(
      fontSize: 12,
      height: 16 / 12,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.8,
    ),
  );

  static ThemeData _build(ColorScheme scheme) => ThemeData(
    colorScheme: scheme,
    scaffoldBackgroundColor: scheme.surface,
    textTheme: _textTheme.apply(
      bodyColor: scheme.onSurface,
      displayColor: scheme.onSurface,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: scheme.surface,
      foregroundColor: scheme.onSurface,
      surfaceTintColor: Colors.transparent,
      scrolledUnderElevation: 0,
      titleTextStyle: _textTheme.titleLarge?.copyWith(color: scheme.onSurface),
      actionsIconTheme: IconThemeData(color: scheme.onSurfaceVariant),
    ),
    cardTheme: CardThemeData(
      color: scheme.surfaceContainer,
      elevation: 0,
      margin: EdgeInsets.zero,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: scheme.outline),
      ),
    ),
    dividerTheme: DividerThemeData(color: scheme.outlineVariant, space: 1),
  );
}
