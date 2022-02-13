import 'dart:math';

import 'package:assorted_layout_widgets/assorted_layout_widgets.dart';
import 'package:climbing_app/app/theme/bloc/app_theme.dart';
import 'package:flutter/material.dart';

class RouteCard extends StatelessWidget {
  const RouteCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colorTheme = AppTheme.of(context).colorTheme;

    return Card(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      elevation: 8,
      child: Padding(
        padding: const Pad(horizontal: 16, vertical: 8),
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(16)),
                child: Image.network(
                  'https://picsum.photos/72',
                  width: 72,
                  height: 72,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      [
                        'Овсянка, сэр',
                        'Трава',
                        '2007',
                        'Ложка дёгтя в бочке дёгтя',
                      ].elementAt(Random().nextInt(4)),
                      style: AppTheme.of(context).textTheme.subtitle1,
                    ),
                    Text(
                      'Категория: 6c+',
                      style: AppTheme.of(context).textTheme.subtitle2,
                    ),
                    Text(
                      'Автор: Саша Макурин',
                      style: AppTheme.of(context).textTheme.subtitle2,
                    ),
                    const Spacer(),
                    Container(
                      height: 8,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: [
                          colorTheme.routeEasy,
                          colorTheme.routeMedium,
                          colorTheme.routeHard,
                        ][Random().nextInt(3)],
                        borderRadius:
                            const BorderRadius.all(Radius.circular(8)),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
