import 'package:climbing_app/core/failure.dart';
import 'package:dartz/dartz.dart';

abstract class StartupRepository {
  bool get isInitialized;
  Future<Either<List<Failure>, void>> initialize();
  Future<Either<List<Failure>, void>> retryInitialization();
}
