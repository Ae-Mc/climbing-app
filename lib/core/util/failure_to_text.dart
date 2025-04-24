import 'package:climbing_app/core/failure.dart';
import 'package:dio/dio.dart';

String failureToText(Failure failure) {
  switch (failure) {
    case ConnectionFailure():
      return "Ошибка соединения";
    case ServerFailure(statusCode: var statusCode):
      return "Произошла ошибка на сервере. Код ошибки: $statusCode";
    case UnknownFailure(originalError: var error):
      if (error == null) {
        return 'Произошла неизвестная ошибка. Свяжитесь с разработчиком';
      }
      if (error is DioException) {
        final statusCode = error.response?.statusCode;
        if (statusCode == null) {
          return "Произошла ошибка сети ($error).";
        }
        return "Произошла ошибка сети. Код ошибки: $statusCode";
      }
      return 'Произошла неизвестная ошибка ($error). Свяжитесь с разработчиком';
  }
}
