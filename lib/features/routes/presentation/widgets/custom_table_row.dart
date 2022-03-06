import 'package:climbing_app/app/theme/bloc/app_theme.dart';
import 'package:flutter/material.dart';

class CustomTableRow extends TableRow {
  CustomTableRow({
    required BuildContext context,
    required String rowHeader,
    required String rowValue,
    Color? chipBackgroundColor,
    Color? chipTextColor,
  }) : super(
          children: [
            Text(rowHeader),
            const SizedBox(),
            Align(
              alignment: Alignment.centerLeft,
              child: Chip(
                visualDensity: const VisualDensity(
                  vertical: VisualDensity.minimumDensity,
                  // ignore: no-equal-arguments
                  horizontal: VisualDensity.minimumDensity,
                ),
                label: Text(
                  rowValue,
                  style: TextStyle(
                    color: chipTextColor ??
                        AppTheme.of(context).colorTheme.background,
                  ),
                ),
                backgroundColor: chipBackgroundColor ??
                    AppTheme.of(context).colorTheme.secondary,
              ),
            ),
          ],
        );
}
