import 'package:climbing_app/core/failure.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'splash_bloc_state.freezed.dart';

@freezed
class SplashBlocState with _$SplashBlocState {
  const factory SplashBlocState() = _SplashBlocState;
  const factory SplashBlocState.failure(Failure failure) =
      SplashBlocStateFailure;
}
