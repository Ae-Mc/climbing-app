import 'package:climbing_app/app/theme/bloc/app_theme_bloc.dart';
import 'package:climbing_app/app/theme/models/app_color_theme.dart';
import 'package:climbing_app/app/theme/models/app_text_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_theme.freezed.dart';

@freezed
class AppTheme with _$AppTheme {
  factory AppTheme({
    required AppColorTheme colorTheme,
    required AppTextTheme textTheme,
  }) = _AppTheme;

  AppTheme._();

  static AppTheme of(BuildContext context) =>
      BlocProvider.of<AppThemeBloc>(context).state;
}
