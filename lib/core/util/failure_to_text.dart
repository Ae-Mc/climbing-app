import 'package:climbing_app/core/failure.dart';

String failureToText(Failure failure) {
  return failure.when(
    connectionFailure: () => "Ошибка соединения",
    serverFailure: (statusCode) =>
        "Произошла ошибка на сервере. Код ошибки: $statusCode",
    unknownFailure: (error) => error == null
        ? 'Произошла неизвестная ошибка. Свяжитесь с разработчиком'
        : 'Произошла неизвестная ошибка ($error). Свяжитесь с разработчиком',
  );
}
