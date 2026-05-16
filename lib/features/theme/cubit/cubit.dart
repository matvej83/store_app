import 'package:clean_architecture_test/core/presentation/theme/app_theme.dart';
import 'package:clean_architecture_test/core/presentation/theme/app_theme_colors.dart';
import 'package:clean_architecture_test/core/usecases/usecase.dart';
import 'package:clean_architecture_test/features/theme/cubit/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../domain/entity/app_theme_mode.dart';
import '../domain/usecases/get_theme_usecase.dart';
import '../domain/usecases/set_theme_usecase.dart';

@lazySingleton
class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit({required this.getThemeUseCase, required this.setThemeUseCase})
    : super(const ThemeState());
  final GetThemeUseCase getThemeUseCase;
  final SetThemeUseCase setThemeUseCase;

  Future<void> loadTheme() async {
    final mode = await getThemeUseCase(NoParams());
    mode.fold(
      (l) {
        emit(
          state.copyWith(
            mode: AppThemeMode.dark,
            theme: AppTheme.dark(AppThemeColors.dark),
          ),
        );
      },
      (r) {
        if (r != null) {
          emit(state.copyWith(theme: _mapToFlutter(r), mode: r));
        } else {
          emit(
            state.copyWith(
              mode: AppThemeMode.dark,
              theme: AppTheme.dark(AppThemeColors.dark),
            ),
          );
        }
      },
    );
  }

  Future<void> changeTheme(AppThemeMode mode) async {
    await setThemeUseCase(SetThemeParams(mode: mode));
    emit(state.copyWith(theme: _mapToFlutter(mode), mode: mode));
  }

  ThemeData _mapToFlutter(AppThemeMode mode) {
    final colors = AppThemeColors.fromMode(mode);
    return colors == AppThemeColors.light
        ? AppTheme.light(colors)
        : AppTheme.dark(colors);
  }
}
