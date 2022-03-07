import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:injectable/injectable.dart';

import 'package:climbing_app/app/theme/bloc/app_theme.dart';

@injectable
class CustomToast {
  final FToast fToast;
  final BuildContext context;

  CustomToast(@factoryParam this.context) : fToast = FToast()..init(context);

  void showTextFailureToast(String text) {
    fToast.showToast(
      gravity: ToastGravity.TOP,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(25.0)),
          color: AppTheme.of(context).colorTheme.error,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.error_outline_rounded,
              color: AppTheme.of(context).colorTheme.onError,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                text,
                style: AppTheme.of(context)
                    .textTheme
                    .body1Regular
                    .copyWith(color: AppTheme.of(context).colorTheme.onError),
                maxLines: 2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
