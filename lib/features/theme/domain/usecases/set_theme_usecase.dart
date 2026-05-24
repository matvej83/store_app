import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:store_app/core/error/failure.dart';
import 'package:store_app/core/usecases/usecase.dart';

import '../entity/app_theme_mode.dart';
import '../repository/theme_repository.dart';

@lazySingleton
class SetThemeUseCase implements UseCase<void, SetThemeParams> {
  SetThemeUseCase(this.repository);

  final ThemeRepository repository;

  @override
  Future<Either<Failure, void>> call(SetThemeParams params) async {
    return await repository.setTheme(mode: params.mode);
  }
}

class SetThemeParams {
  SetThemeParams({required this.mode});

  final AppThemeMode mode;
}
