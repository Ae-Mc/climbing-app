import 'package:climbing_app/core/constants.dart';
import 'package:climbing_app/core/failure.dart';
import 'package:climbing_app/core/util/handle_dio_connection_error.dart';
import 'package:climbing_app/features/routes/data/datasources/routes_remote_datasource.dart';
import 'package:climbing_app/features/routes/domain/entities/route.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
part 'routes_remote_datasource_impl.g.dart';

@Singleton(as: RoutesRemoteDatasource)
class RoutesRemoteDatasourceImpl implements RoutesRemoteDatasource {
  final RoutesApi api;

  RoutesRemoteDatasourceImpl(this.api);

  @override
  Future<Either<Failure, List<Route>>> allRoutes() async {
    try {
      return Right(await api.routes());
    } on DioError catch (error) {
      return Left(handleDioConnectionError(error).fold<Failure>(
        (l) => l,
        (error) {
          final statusCode = error.response?.statusCode;
          if (statusCode != null) {
            return ServerFailure(statusCode: statusCode);
          }

          return const UnknownFailure();
        },
      ));
    }
  }

  @override
  Future<Either<Failure, void>> removeRoute(String id) async {
    try {
      return Right(await api.removeRoute(id));
    } on DioError catch (error) {
      return Left(handleDioConnectionError(error).fold<Failure>(
        (l) => l,
        (error) {
          final statusCode = error.response?.statusCode;
          if (statusCode != null) {
            return ServerFailure(statusCode: statusCode);
          }

          return const UnknownFailure();
        },
      ));
    }
  }
}

@injectable
@RestApi(baseUrl: '$apiHostUrl/api/v1/')
abstract class RoutesApi {
  @GET('/routes')
  Future<List<Route>> routes();

  @DELETE('/routes/{id}')
  Future<void> removeRoute(@Path() String id);

  @factoryMethod
  factory RoutesApi(Dio dio) => _RoutesApi(dio);
}
