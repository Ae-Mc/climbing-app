import 'package:climbing_app/core/failure.dart';
import 'package:climbing_app/features/splash/domain/repositories/startup_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@Singleton(as: StartupRepository)
class StartupRepositoryImpl implements StartupRepository {
  bool _isInited = false;

  @override
  Future<Either<Failure, void>> initialize() async {
    // ignore: avoid-ignoring-return-values
    await Future.delayed(const Duration(seconds: 3));

    // return const Left(Failure('Initialization error'));

    _isInited = true;

    return const Right(null);
  }

  @override
  bool get isInited => _isInited;
}
