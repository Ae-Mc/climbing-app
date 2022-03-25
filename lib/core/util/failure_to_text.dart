import 'package:climbing_app/core/failure.dart';

String failureToText(Failure failure) {
  return failure.when(
    connectionFailure: () => "Ошибка соединения",
    serverFailure: (statusCode) =>
        "Произошла ошибка на сервере. Код ошибки: $statusCode",
    unknownFailure: () =>
        'Произошла неизвестная ошибка. Свяжитесь с разработчиком',
  );
}
