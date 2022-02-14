import 'package:climbing_app/core/failure.dart';
import 'package:climbing_app/features/routes/domain/entities/route.dart';
import 'package:dartz/dartz.dart';

abstract class RoutesRemoteDatasource {
  Future<Either<Failure, List<Route>>> allRoutes();
}
