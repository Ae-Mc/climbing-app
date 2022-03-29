import 'package:assorted_layout_widgets/assorted_layout_widgets.dart';
import 'package:climbing_app/app/theme/bloc/app_theme.dart';
import 'package:climbing_app/core/util/category_to_color.dart';
import 'package:climbing_app/features/routes/domain/entities/category.dart';
import 'package:flutter/material.dart';

class CategoryCard extends StatelessWidget {
  final Category category;
  final bool isSelected;
  final void Function() onTap;

  const CategoryCard({
    Key? key,
    required this.category,
    required this.isSelected,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colorTheme = AppTheme.of(context).colorTheme;
    final textTheme = AppTheme.of(context).textTheme;

    return Card(
      color: isSelected
          ? colorTheme.primary
          : categoryToColor(category, colorTheme),
      shape: StadiumBorder(
        side: isSelected
            ? BorderSide(width: 3, color: colorTheme.secondary)
            : BorderSide.none,
      ),
      child: InkWell(
        onTap: onTap,
        customBorder: const StadiumBorder(),
        child: Padding(
          padding: const Pad(all: 8),
          child: Text(
            category.toString(),
            style: textTheme.subtitle1.copyWith(color: colorTheme.onPrimary),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
