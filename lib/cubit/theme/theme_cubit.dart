import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../services/shared_preferences_service.dart';
import 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  final SharedPreferencesService _preferencesService;

  ThemeCubit(this._preferencesService)
      : super(
    const ThemeState(
      themeMode: ThemeMode.light,
    ),
  );

  Future<void> loadTheme() async {
    final isDarkMode = await _preferencesService.getTheme();

    emit(
      ThemeState(
        themeMode: isDarkMode
            ? ThemeMode.dark
            : ThemeMode.light,
      ),
    );
  }

  Future<void> toggleTheme() async {
    final isDarkMode =
        state.themeMode == ThemeMode.dark;

    final newThemeMode =
    isDarkMode
        ? ThemeMode.light
        : ThemeMode.dark;

    await _preferencesService.saveTheme(
      newThemeMode == ThemeMode.dark,
    );

    emit(
      ThemeState(
        themeMode: newThemeMode,
      ),
    );
  }
}