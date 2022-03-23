import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:climbing_app/app/theme/bloc/app_theme.dart';

class CustomToast {
  final FToast fToast;
  final BuildContext context;

  CustomToast(this.context) : fToast = FToast()..init(context);

  void showTextFailureToast(String text) {
    const borderRadius = BorderRadius.all(Radius.circular(25.0));
    final colorTheme = AppTheme.of(context).colorTheme;

    fToast.showToast(
      gravity: ToastGravity.TOP,
      child: InkWell(
        borderRadius: borderRadius,
        onTap: () => fToast.removeCustomToast(),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
          decoration: BoxDecoration(
            borderRadius: borderRadius,
            color: colorTheme.error,
          ),
          child: IntrinsicWidth(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.error_outline_rounded, color: colorTheme.onError),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    text,
                    style: AppTheme.of(context)
                        .textTheme
                        .body1Regular
                        .copyWith(color: colorTheme.onError),
                    maxLines: 2,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
