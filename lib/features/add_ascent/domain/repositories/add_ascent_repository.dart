import 'package:climbing_app/core/failure.dart';
import 'package:climbing_app/features/add_ascent/domain/entities/ascent_create.dart';
import 'package:dartz/dartz.dart';

abstract class AddAscentRepository {
  Future<Either<Failure, void>> addAscent(AscentCreate ascent);
}
