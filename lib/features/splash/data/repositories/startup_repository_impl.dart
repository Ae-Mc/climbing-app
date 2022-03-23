import 'package:climbing_app/core/failure.dart';
import 'package:climbing_app/features/splash/data/models/initialization_status.dart';
import 'package:climbing_app/features/splash/data/repositories/startup_repository_impl.config.dart';
import 'package:climbing_app/features/splash/domain/repositories/startup_repository.dart';
import 'package:climbing_app/features/user/presentation/bloc/user_bloc.dart';
import 'package:climbing_app/features/user/presentation/bloc/user_event.dart';
import 'package:climbing_app/features/user/presentation/bloc/user_state.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:logger/logger.dart';

@InjectableInit(initializerName: r"configureDependencies")
class StartupRepositoryImpl implements StartupRepository {
  InitializationStatus initializationStatus = InitializationStatus();
  final BuildContext context;

  StartupRepositoryImpl(this.context);

  @override
  bool get isInitialized {
    return initializationStatus.statuses.every((element) => element);
  }

  @override
  Future<Either<List<Failure>, void>> initialize() async {
    return await initializeAllNotInitialized();
  }

  @override
  Future<Either<List<Failure>, void>> retryInitialization() async {
    return await initializeAllNotInitialized();
  }

  Future<Either<List<Failure>, void>> initializeAllNotInitialized() async {
    List<Failure> failures = [
      if (!initializationStatus.intlInitialized)
        ...(await initializeIntl()).fold(
          (l) => [l],
          (r) {
            initializationStatus =
                initializationStatus.copyWith(intlInitialized: true);

            return [];
          },
        ),
      if (!initializationStatus.getItInitialized)
        ...(await intializeGetIt()).fold((l) => [l], (r) {
          initializationStatus =
              initializationStatus.copyWith(getItInitialized: true);

          return [];
        }),
      if (initializationStatus.getItInitialized &&
          !initializationStatus.userBlocInitialized)
        ...(await initializeUserBloc()).fold((l) => [l], (r) {
          initializationStatus =
              initializationStatus.copyWith(userBlocInitialized: true);

          return [];
        }),
    ];

    return failures.isEmpty ? const Right(null) : Left(failures);
  }

  Future<Either<Failure, void>> initializeIntl() async {
    try {
      await initializeDateFormatting();

      return const Right(null);
    } catch (e) {
      return const Left(Failure.unknownFailure());
    }
  }

  Future<Either<Failure, void>> intializeGetIt() async {
    try {
      // ignore: avoid-ignoring-return-values
      await configureDependencies(GetIt.I);

      return const Right(null);
    } catch (e) {
      Logger().e('Error occured initializing GetIt', e);

      return const Left(Failure.unknownFailure());
    }
  }

  Future<Either<Failure, void>> initializeUserBloc() async {
    final UserBloc userBloc = BlocProvider.of(context);
    userBloc.add(const UserEvent.initialize());

    return (await userBloc.stream
            .firstWhere((element) => element is! UserStateLoading))
        .maybeWhen(
      initializationFailure: (failure) => Left(failure),
      orElse: () => const Right(null),
    );
  }
}
