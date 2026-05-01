import 'package:clean_architecture_test/core/presentation/theme/app_theme.dart';
import 'package:clean_architecture_test/core/presentation/theme/app_theme_colors.dart';
import 'package:clean_architecture_test/features/theme/cubit/cubit.dart';
import 'package:clean_architecture_test/features/theme/domain/entity/app_theme_mode.dart';
import 'package:clean_architecture_test/features/theme/domain/repository/theme_repository.dart';
import 'package:flutter/material.dart';

/// Provider for theme management that can be used across the application.
///
/// This provider simplifies access to theme data and handles theme persistence.
class ThemeProvider with ChangeNotifier {
  ThemeProvider({
    required this.cubit,
    required this.repository,
  }) {
    _loadTheme();
  }

  final ThemeCubit cubit;
  final ThemeRepository repository;

  AppThemeMode _currentMode = AppThemeMode.dark;
  ThemeData? _currentTheme;

  AppThemeMode get currentMode => _currentMode;
  ThemeData? get currentTheme => _currentTheme;

  /// Loads the saved theme from repository.
  Future<void> _loadTheme() async {
    final result = repository.getTheme();
    result.fold(
      (l) {
        _currentMode = AppThemeMode.dark;
        _currentTheme = AppTheme.dark(AppThemeColors.dark);
      },
      (r) {
        _currentMode = r ?? AppThemeMode.dark;
        _currentTheme = _mapToThemeData(_currentMode);
      },
    );
    notifyListeners();
  }

  /// Changes the theme and persists it.
  Future<void> setTheme(AppThemeMode mode) async {
    _currentMode = mode;
    await repository.setTheme(mode: mode);
    _currentTheme = _mapToThemeData(mode);
    notifyListeners();
  }

  /// Returns the current theme data.
  ThemeData getThemeData() {
    return _currentTheme ?? AppTheme.dark(AppThemeColors.dark);
  }

  ThemeData _mapToThemeData(AppThemeMode mode) {
    final colors = AppThemeColors.fromMode(mode);
    return mode == AppThemeMode.light
        ? AppTheme.light(colors)
        : AppTheme.dark(colors);
  }
}