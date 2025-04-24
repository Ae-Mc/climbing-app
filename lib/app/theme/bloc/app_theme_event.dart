import 'package:freezed_annotation/freezed_annotation.dart';
part 'app_theme_event.freezed.dart';

@freezed
sealed class AppThemeEvent with _$AppThemeEvent {
  const factory AppThemeEvent.setLightTheme() = AppThemeEventSetLightTheme;
}
