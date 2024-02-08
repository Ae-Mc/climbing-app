import 'package:climbing_app/core/failure.dart';
import 'package:climbing_app/core/entities/ascent.dart';
import 'package:dartz/dartz.dart';

abstract class ActivityFeedRepository {
  Future<Either<Failure, List<Ascent>>> recentAscents();
}
