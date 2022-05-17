import 'package:climbing_app/core/util/handle_dio_connection_error.dart';
import 'package:climbing_app/features/add_ascent/data/datasources/add_ascent_remote_datasource.dart';
import 'package:climbing_app/features/add_ascent/domain/entities/ascent_create.dart';
import 'package:climbing_app/core/failure.dart';
import 'package:climbing_app/features/add_ascent/domain/repositories/add_ascent_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';

@Singleton(as: AddAscentRepository)
class AddAscentRepositoryImpl implements AddAscentRepository {
  final AddAscentRemoteDatasource remoteDatasource;

  AddAscentRepositoryImpl(this.remoteDatasource);

  @override
  Future<Either<Failure, void>> addAscent(AscentCreate ascent) async {
    try {
      // ignore: avoid-ignoring-return-values
      await remoteDatasource.addAscent(ascent);

      return const Right(null);
    } on DioError catch (error) {
      return Left(handleDioConnectionError(error).fold((l) => l, (r) {
        GetIt.I<Logger>().e(error.response?.data, error);
        GetIt.I<Logger>().d(error.requestOptions.data);
        GetIt.I<Logger>().d(error.requestOptions.uri);

        return Failure.unknownFailure(error);
      }));
    }
  }
}
