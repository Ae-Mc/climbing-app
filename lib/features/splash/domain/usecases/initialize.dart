import 'package:climbing_app/core/failure.dart';
import 'package:climbing_app/core/usecase.dart';
import 'package:climbing_app/features/splash/domain/repositories/startup_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@singleton
class Initialize extends UseCase<void, void> {
  final StartupRepository repository;

  Initialize(this.repository);

  @override
  Future<Either<Failure, void>> call(void params) async {
    return repository.initialize();
  }
}
