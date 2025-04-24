import 'package:assorted_layout_widgets/assorted_layout_widgets.dart';
import 'package:climbing_app/app/theme/bloc/app_theme.dart';
import 'package:flutter/material.dart';

class FailureWidget extends StatelessWidget {
  final String title;
  final String? body;
  final void Function()? onRetry;

  const FailureWidget({
    super.key,
    required this.title,
    this.body,
    this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          Icons.wifi_off_rounded,
          size: 72,
          color: AppTheme.of(context).colorTheme.primary,
        ),
        Text(
          title,
          style: AppTheme.of(context).textTheme.subtitle1,
          textAlign: TextAlign.center,
          maxLines: 3,
        ),
        if (body != null)
          Text(
            // ignore: avoid-non-null-assertion
            body!,
            style: AppTheme.of(context).textTheme.body1Regular,
            maxLines: 10,
            textAlign: TextAlign.center,
          ),
        if (onRetry != null)
          Center(
            child: Padding(
              padding: const Pad(top: 16),
              child: ElevatedButton(
                onPressed: onRetry,
                style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(
                    AppTheme.of(context).colorTheme.primary,
                  ),
                ),
                child: const Text('Повторить попытку'),
              ),
            ),
          ),
      ],
    );
  }
}
