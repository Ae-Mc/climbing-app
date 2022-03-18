import 'package:freezed_annotation/freezed_annotation.dart';
part 'splash_bloc_event.freezed.dart';

@freezed
class SplashBlocEvent with _$SplashBlocEvent {
  const factory SplashBlocEvent.init() = SplashBlocEventInit;
}
