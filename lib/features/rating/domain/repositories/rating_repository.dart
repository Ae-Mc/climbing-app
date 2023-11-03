import 'package:climbing_app/core/failure.dart';
import 'package:climbing_app/features/rating/domain/entities/score.dart';
import 'package:dartz/dartz.dart';

abstract class RatingRepository {
  Future<Either<Failure, List<Score>>> getRating(
      bool mustBeStudent, bool mustBeFemale);
}
