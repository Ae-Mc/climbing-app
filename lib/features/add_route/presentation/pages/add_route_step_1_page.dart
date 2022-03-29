import 'package:assorted_layout_widgets/assorted_layout_widgets.dart';
import 'package:auto_route/auto_route.dart';
import 'package:climbing_app/app/router/app_router.dart';
import 'package:climbing_app/app/theme/bloc/app_theme.dart';
import 'package:climbing_app/core/widgets/styled_text_field.dart';
import 'package:climbing_app/features/add_route/presentation/widgets/header.dart';
import 'package:flutter/material.dart';

class AddRouteStep1Page extends StatelessWidget {
  const AddRouteStep1Page({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colorTheme = AppTheme.of(context).colorTheme;

    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: const Pad(all: 16),
            child: Column(
              children: [
                const Header(stepNum: 1),
                const SizedBox(height: 32),
                Text(
                  'ШАГ 1: Заполните основные параметры\n\nВведите основные параметры трассы: её название, цвет меток и дату постановки.',
                  style: AppTheme.of(context).textTheme.body2Regular,
                  maxLines: 20,
                ),
                const SizedBox(height: 32),
                StyledTextField(
                  hintText: 'Название',
                  suffixIcon: Icon(
                    Icons.abc,
                    color: colorTheme.primary,
                  ),
                ),
                const SizedBox(height: 16),
                StyledTextField(
                  hintText: 'Цвет меток',
                  suffixIcon: Icon(
                    Icons.color_lens_rounded,
                    color: colorTheme.primary,
                  ),
                ),
                const SizedBox(height: 16),
                StyledTextField(
                  hintText: 'Дата постановки',
                  suffixIcon: Icon(
                    Icons.calendar_today,
                    color: colorTheme.primary,
                  ),
                ),
              ],
            ),
          ),
        ),
        SliverFillRemaining(
          hasScrollBody: false,
          child: Container(
            alignment: Alignment.bottomCenter,
            padding: const Pad(bottom: 16, horizontal: 16),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () =>
                    AutoRouter.of(context).push(const AddRouteStep2Route()),
                child: const Text('Вперёд'),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
