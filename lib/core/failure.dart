import 'package:freezed_annotation/freezed_annotation.dart';
part 'failure.freezed.dart';

@freezed
class Failure with _$Failure {
  const factory Failure.connectionFailure() = ConnectionFailure;
  const factory Failure.serverFailure({required int statusCode}) =
      ServerFailure;
  const factory Failure.unknownFailure() = UnknownFailure;
}
