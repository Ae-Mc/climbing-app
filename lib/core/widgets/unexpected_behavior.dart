import 'package:assorted_layout_widgets/assorted_layout_widgets.dart';
import 'package:climbing_app/app/theme/bloc/app_theme.dart';
import 'package:flutter/material.dart';

class UnexpectedBehavior extends StatelessWidget {
  const UnexpectedBehavior({super.key});

  @override
  Widget build(BuildContext context) {
    final colorTheme = AppTheme.of(context).colorTheme;
    final textTheme = AppTheme.of(context).textTheme;

    return Container(
      decoration:
          BoxDecoration(color: colorTheme.error, shape: BoxShape.circle),
      padding: const Pad(all: 16),
      child: Text(
        "Неожиданное поведение. Свяжитесь с разработчиком! (Он обещал шоколадку, отговоркам не верьте!)",
        style: textTheme.title.copyWith(color: colorTheme.onError),
        maxLines: 8,
      ),
    );
  }
}
