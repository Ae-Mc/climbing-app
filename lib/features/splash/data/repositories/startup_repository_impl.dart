import 'package:climbing_app/core/failure.dart';
import 'package:climbing_app/features/splash/domain/repositories/startup_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:climbing_app/features/splash/data/repositories/startup_repository_impl.config.dart';

@InjectableInit(initializerName: r"configureDependencies")
class StartupRepositoryImpl implements StartupRepository {
  bool _isInited = false;

  @override
  Future<Either<Failure, void>> initialize() async {
    // ignore: avoid-ignoring-return-values
    // await Future.delayed(const Duration(seconds: 3));

    // ignore: avoid-ignoring-return-values
    await configureDependencies(GetIt.I);
    await initializeDateFormatting('ru');

    // return const Left(Failure('Initialization error'));

    _isInited = true;

    return const Right(null);
  }

  @override
  bool get isInited => _isInited;
}
