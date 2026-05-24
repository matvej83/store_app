import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:store_app/core/error/failure.dart';
import 'package:store_app/core/usecases/usecase.dart';
import 'package:store_app/features/theme/domain/repository/theme_repository.dart';

import '../entity/app_theme_mode.dart';

@lazySingleton
class GetThemeUseCase implements UseCase<AppThemeMode?, NoParams> {
  GetThemeUseCase(this.repository);

  final ThemeRepository repository;

  @override
  Future<Either<Failure, AppThemeMode?>> call(NoParams params) async {
    return repository.getTheme();
  }
}
