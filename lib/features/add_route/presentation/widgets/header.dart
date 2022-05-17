import 'package:climbing_app/app/theme/bloc/app_theme.dart';
import 'package:climbing_app/core/widgets/custom_back_button.dart';
import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  static const stepCount = 3;
  final int stepNum;

  const Header({Key? key, required this.stepNum}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colorTheme = AppTheme.of(context).colorTheme;
    final textTheme = AppTheme.of(context).textTheme;

    return Row(
      children: [
        const CustomBackButton(),
        const SizedBox(width: 16),
        Expanded(
          child: Text('Добавление трассы', style: textTheme.title, maxLines: 2),
        ),
        const SizedBox(width: 16),
        Text.rich(
          TextSpan(children: [
            TextSpan(
              text: '$stepNum',
              style: TextStyle(color: colorTheme.secondary),
            ),
            const TextSpan(text: '/$stepCount'),
          ]),
          style:
              textTheme.subtitle1.copyWith(color: colorTheme.secondaryVariant),
        ),
      ],
    );
  }
}
