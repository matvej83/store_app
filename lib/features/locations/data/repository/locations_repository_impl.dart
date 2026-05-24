import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:store_app/core/error/failure.dart';
import 'package:store_app/core/error/mapper.dart';
import 'package:store_app/features/locations/domain/entity/location_entity.dart';
import 'package:store_app/features/locations/domain/repository/locations_repository.dart';

import '../data_sources/locations_remote_data_source.dart';
import '../models/location_model.dart';

@LazySingleton(as: LocationsRepository)
class LocationsRepositoryImpl implements LocationsRepository {
  LocationsRepositoryImpl({required this.locationsRemoteDataSource});

  final LocationsRemoteDataSource locationsRemoteDataSource;

  @override
  Future<Either<Failure, List<LocationEntity>>> fetchLocations({
    List<double>? origin,
    int? radius,
  }) async {
    try {
      final locations = await locationsRemoteDataSource.fetchLocations(
        origin: origin,
        radius: radius,
      );
      final list = locations?.map((e) => e.toEntity()).toList() ?? [];
      return Right(list);
    } catch (e) {
      return Left(mapExceptionToFailure(e));
    }
  }
}
