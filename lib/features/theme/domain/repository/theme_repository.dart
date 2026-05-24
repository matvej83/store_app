import 'package:dartz/dartz.dart';
import 'package:store_app/core/error/failure.dart';

import '../entity/app_theme_mode.dart';

abstract class ThemeRepository {
  Future<Either<Failure, void>> setTheme({required AppThemeMode mode});

  Either<Failure, AppThemeMode?> getTheme();
}
