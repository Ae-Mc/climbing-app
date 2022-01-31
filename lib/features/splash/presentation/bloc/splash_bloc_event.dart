import 'package:freezed_annotation/freezed_annotation.dart';
part 'splash_bloc_event.freezed.dart';

@freezed
class SplashBlocEvent with _$SplashBlocEvent {
  const factory SplashBlocEvent.init() = SplashBlocEventInit;
}

@freezed
class SplashBlocSingleResult with _$SplashBlocSingleResult {
  const factory SplashBlocSingleResult.loadFinished() =
      SplashBlocSingleResultLoadFinished;
}
