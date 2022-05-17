import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:climbing_app/app/theme/bloc/app_theme.dart';

class CustomToast {
  final FToast fToast;
  final BuildContext context;

  CustomToast(this.context) : fToast = FToast()..init(context);

  void showTextFailureToast(String text) {
    final colorTheme = AppTheme.of(context).colorTheme;

    fToast.showToast(
      gravity: ToastGravity.TOP,
      child: getToastWidget(
        backgroundColor: colorTheme.error,
        icon: Icon(Icons.error_outline_rounded, color: colorTheme.onError),
        foregroundColor: colorTheme.onError,
        text: text,
      ),
    );
  }

  void showTextSuccessToast(String text) {
    final colorTheme = AppTheme.of(context).colorTheme;

    fToast.showToast(
      gravity: ToastGravity.TOP,
      child: getToastWidget(
        backgroundColor: colorTheme.success,
        icon: Icon(Icons.done, color: colorTheme.primary),
        foregroundColor: colorTheme.onSuccess,
        text: text,
      ),
    );
  }

  Widget getToastWidget({
    required Widget icon,
    required String text,
    required Color backgroundColor,
    required Color foregroundColor,
  }) {
    const borderRadius = BorderRadius.all(Radius.circular(25.0));

    return InkWell(
      borderRadius: borderRadius,
      onTap: () => fToast.removeCustomToast(),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
        decoration: BoxDecoration(
          borderRadius: borderRadius,
          color: backgroundColor,
        ),
        child: IntrinsicWidth(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              icon,
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  text,
                  style: AppTheme.of(context)
                      .textTheme
                      .body1Regular
                      .copyWith(color: foregroundColor),
                  maxLines: 2,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
