import 'dart:io';

import 'package:climbing_app/core/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

Either<Failure, DioException> handleDioConnectionError(DioException error) {
  if ([
        DioExceptionType.cancel,
        DioExceptionType.connectionTimeout,
        DioExceptionType.connectionError,
        DioExceptionType.receiveTimeout,
        DioExceptionType.sendTimeout,
      ].contains(error.type) ||
      error.error is SocketException ||
      error.error is HttpException) {
    return const Left(ConnectionFailure());
  }

  return Right(error);
}
