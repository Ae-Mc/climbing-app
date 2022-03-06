import 'package:climbing_app/core/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

Either<Failure, DioError> handleDioConnectionError(DioError error) {
  if ([
    DioErrorType.cancel,
    DioErrorType.connectTimeout,
    DioErrorType.receiveTimeout,
    DioErrorType.sendTimeout,
  ].contains(error.type)) {
    return const Left(ConnectionFailure());
  }

  return Right(error);
}
