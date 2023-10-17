import 'package:climbing_app/core/failure.dart';
import 'package:dio/dio.dart';

String failureToText(Failure failure) {
  return failure.when(
    connectionFailure: () => "Ошибка соединения",
    serverFailure: (statusCode) =>
        "Произошла ошибка на сервере. Код ошибки: $statusCode",
    unknownFailure: (error) {
      late final String result;
      if (error == null) {
        result = 'Произошла неизвестная ошибка. Свяжитесь с разработчиком';
      } else if (error is DioException) {
        final statusCode = error.response?.statusCode;
        if (statusCode == null) {
          result = "Произошла ошибка сети ($error).";
        } else {
          result = "Произошла ошибка сети. Код ошибки: $statusCode";
        }
      } else {
        result =
            'Произошла неизвестная ошибка ($error). Свяжитесь с разработчиком';
      }
      return result;
    },
  );
}
