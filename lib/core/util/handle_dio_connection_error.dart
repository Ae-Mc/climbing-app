import 'dart:io';

import 'package:climbing_app/core/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

Either<Failure, DioException> handleDioException(DioException error) {
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
  if (DioExceptionType.badResponse == error.type) {
    final statusCode = error.response?.statusCode;
    if (statusCode != null && statusCode >= 500) {
      return Left(ServerFailure(statusCode: statusCode));
    }
  }

  return Right(error);
}
