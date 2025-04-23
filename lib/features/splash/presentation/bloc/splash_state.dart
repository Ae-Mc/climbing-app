import 'package:climbing_app/core/failure.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'splash_state.freezed.dart';

@freezed
sealed class SplashState with _$SplashState {
  const factory SplashState.loaded() = SplashStateLoaded;
  const factory SplashState.loading() = SplashStateLoading;
  const factory SplashState.failure(Failure failure) = SplashStateFailure;
}
