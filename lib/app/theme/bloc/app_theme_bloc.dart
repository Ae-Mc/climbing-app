import 'package:climbing_app/app/theme/bloc/app_theme.dart';
import 'package:climbing_app/app/theme/bloc/app_theme_event.dart';
import 'package:climbing_app/app/theme/models/app_color_theme.dart';
import 'package:climbing_app/app/theme/models/app_text_theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppThemeBloc extends Bloc<AppThemeEvent, AppTheme> {
  AppThemeBloc()
      : super(AppTheme(
          colorTheme: const LightColorTheme(),
          textTheme: const BaseTextTheme(),
        )) {
    on<AppThemeEventSetLightTheme>(
      (event, emit) =>
          emit(state.copyWith(colorTheme: const LightColorTheme())),
    );
  }
}
