import 'package:climbing_app/core/failure.dart';
import 'package:dartz/dartz.dart';

abstract class StartupRepository {
  Future<Either<Failure, void>> initialize();
  bool get isInited;
}
