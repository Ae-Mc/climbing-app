import 'package:climbing_app/core/failure.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'splash_event.freezed.dart';

@freezed
sealed class SplashEvent with _$SplashEvent {
  const factory SplashEvent.init() = SplashEventInit;
  const factory SplashEvent.retryInitialization() =
      SplashEventRetryInitialization;
}

@freezed
sealed class SplashSingleResult with _$SplashSingleResult {
  const factory SplashSingleResult.failure(Failure failure) =
      SplashSingleResultFailure;
}
