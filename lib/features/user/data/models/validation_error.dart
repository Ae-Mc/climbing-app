import 'package:freezed_annotation/freezed_annotation.dart';

part 'validation_error.freezed.dart';
part 'validation_error.g.dart';

@freezed
sealed class ValidationError with _$ValidationError {
  const factory ValidationError(List<Detail> detail) = _ValidationError;

  factory ValidationError.fromJson(Map<String, dynamic> json) =>
      _$ValidationErrorFromJson(json);
}

@freezed
sealed class Detail with _$Detail {
  const factory Detail({
    required List<String> loc,
    required String msg,
    required String type,
  }) = _Detail;

  factory Detail.fromJson(Map<String, dynamic> json) => _$DetailFromJson(json);
}
