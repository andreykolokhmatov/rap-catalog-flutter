import 'package:flutter/material.dart';

import '../../features/artist/domain/artist_model.dart';

abstract final class AppColors {
  // Тёмная тема
  static const darkPrimary = Color(0xFF1DB954);
  static const darkOnPrimary = Color(0xFF000000);
  static const darkPrimaryContainer = Color(0xFF0E5C2A);
  static const darkOnPrimaryContainer = Color(0xFFB9F6CA);
  static const darkSecondary = Color(0xFFB3B3B3);
  static const darkOnSecondary = Color(0xFF000000);
  static const darkSurface = Color(0xFF000000);
  static const darkOnSurface = Color(0xFFFFFFFF);
  static const darkSurfaceContainer = Color(0xFF121212);
  static const darkSurfaceContainerHigh = Color(0xFF1E1E1E);
  static const darkOnSurfaceVariant = Color(0xFFB3B3B3);
  static const darkOutline = Color(0xFF3E3E3E);
  static const darkOutlineVariant = Color(0xFF1F1F1F);
  static const darkError = Color(0xFFEF5350);
  static const darkOnError = Color(0xFF000000);

  // Светлая тема
  static const lightPrimary = Color(0xFF15803D);
  static const lightOnPrimary = Color(0xFFFFFFFF);
  static const lightPrimaryContainer = Color(0xFFBBF7D0);
  static const lightOnPrimaryContainer = Color(0xFF052E16);
  static const lightSecondary = Color(0xFF4338CA);
  static const lightOnSecondary = Color(0xFFFFFFFF);
  static const lightSurface = Color(0xFFF8FAFC);
  static const lightOnSurface = Color(0xFF0F0F23);
  static const lightSurfaceContainer = Color(0xFFFFFFFF);
  static const lightSurfaceContainerHigh = Color(0xFFF1F5F9);
  static const lightOnSurfaceVariant = Color(0xFF4B5162);
  static const lightOutline = Color(0xFFCBD5E1);
  static const lightOutlineVariant = Color(0xFFE2E8F0);
  static const lightError = Color(0xFFDC2626);
  static const lightOnError = Color(0xFFFFFFFF);

  // Цвет жанра — цвет данных, от темы не зависит, поэтому подпись на нём всегда белая.
  static const onGenre = Color(0xFFFFFFFF);

  static Color genre(Genre genre) => switch (genre) {
    Genre.hipHop => const Color(0xFF6A3DC8),
    Genre.rap => const Color(0xFF7E57C2),
    Genre.popRap => const Color(0xFFD81B8C),
    Genre.eastCoast => const Color(0xFF1565C0),
    Genre.westCoast => const Color(0xFFBF360C),
    Genre.southern => const Color(0xFF00695C),
    Genre.gangstaRap => const Color(0xFFB71C1C),
    Genre.gFunk => const Color(0xFF8E24AA),
    Genre.conscious => const Color(0xFF2E7D32),
    Genre.political => const Color(0xFF455A64),
    Genre.hardcore => const Color(0xFF424242),
    Genre.boomBap => const Color(0xFF795548),
    Genre.jazzRap => const Color(0xFF0277BD),
    Genre.instrumental => const Color(0xFF00838F),
    Genre.experimental => const Color(0xFF5E35B1),
    Genre.alternative => const Color(0xFF3949AB),
    Genre.underground => const Color(0xFF37474F),
    Genre.oldSchool => const Color(0xFF7E5700),
    Genre.rapRock => const Color(0xFFC62828),
    Genre.trap => const Color(0xFF6D4C41),
    Genre.crunk => const Color(0xFFAD1457),
    Genre.emoRap => const Color(0xFF7B1FA2),
    Genre.cloudRap => const Color(0xFF01579B),
    Genre.trapMetal => const Color(0xFF212121),
    Genre.rage => const Color(0xFFD32F2F),
  };
}
