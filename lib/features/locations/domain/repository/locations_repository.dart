import 'package:dartz/dartz.dart';
import 'package:store_app/core/error/failure.dart';

import '../entity/location_entity.dart';

abstract class LocationsRepository {
  Future<Either<Failure, List<LocationEntity>>> fetchLocations({
    List<double>? origin,
    int? radius,
  });
}
