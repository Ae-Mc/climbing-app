import 'package:assorted_layout_widgets/assorted_layout_widgets.dart';
import 'package:flutter/material.dart';

import 'package:climbing_app/app/theme/bloc/app_theme.dart';
import 'package:toastification/toastification.dart';

class CustomToast {
  final BuildContext context;

  CustomToast(this.context);

  void showTextFailureToast(String text) {
    final colorTheme = AppTheme.of(context).colorTheme;

    _showToast(
      primaryColor: colorTheme.error,
      onPrimaryColor: colorTheme.onError,
      icon: Icon(Icons.info_outline, color: colorTheme.onError),
      style: ToastificationStyle.fillColored,
      title: 'Ошибка!',
      description: text,
    );
  }

  void showTextSuccessToast(String text) {
    final colorTheme = AppTheme.of(context).colorTheme;

    _showToast(
      primaryColor: colorTheme.success,
      onPrimaryColor: colorTheme.onSuccess,
      icon: Icon(Icons.done, color: colorTheme.primary),
      style: ToastificationStyle.fillColored,
      description: text,
    );
  }

  void _showToast({
    String? description,
    String? title,
    EdgeInsets padding = const Pad(horizontal: 16, vertical: 8),
    ToastificationStyle style = ToastificationStyle.fillColored,
    required Widget icon,
    required Color primaryColor,
    required Color onPrimaryColor,
  }) {
    toastification.show(
      autoCloseDuration: const Duration(seconds: 3),
      context: context,
      primaryColor: primaryColor,
      icon: icon,
      padding: padding,
      style: style,
      title: title == null
          ? null
          : Text(title, style: TextStyle(color: onPrimaryColor)),
      description: description == null
          ? null
          : Text(description, style: TextStyle(color: onPrimaryColor)),
    );
  }
}
