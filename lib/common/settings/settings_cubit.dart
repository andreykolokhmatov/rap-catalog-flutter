import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'settings_state.dart';

/// Тема и язык живут в памяти сессии, на диск ничего не пишется.
class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit() : super(const SettingsState());

  void toggleTheme() => emit(
    state.copyWith(themeMode: state.isDark ? ThemeMode.light : ThemeMode.dark),
  );

  void toggleLocale() => emit(
    state.copyWith(
      locale: Locale(state.locale.languageCode == 'ru' ? 'en' : 'ru'),
    ),
  );
}
