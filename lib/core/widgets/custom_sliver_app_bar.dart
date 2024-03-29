import 'package:climbing_app/app/theme/bloc/app_theme.dart';
import 'package:flutter/material.dart';

class CustomSliverAppBar extends StatelessWidget {
  final String text;
  final Widget? leading;
  final List<Widget>? actions;

  final bool showLeading;

  const CustomSliverAppBar({
    super.key,
    required this.text,
    this.showLeading = true,
    this.leading,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      automaticallyImplyLeading: false,
      backgroundColor: AppTheme.of(context).colorTheme.background,
      forceElevated: true,
      foregroundColor: AppTheme.of(context).colorTheme.secondary,
      floating: true,
      leading: showLeading
          ? Center(
              child: leading ??
                  IconButton(
                    onPressed: () => openDrawer(context),
                    icon: const Icon(Icons.menu_rounded, size: 24),
                  ),
            )
          : null,
      title: Text(text),
      actions: actions,
    );
  }

  static void openDrawer(BuildContext context) {
    final scaffold = Scaffold.maybeOf(context);
    if (scaffold != null) {
      if (!scaffold.hasDrawer) {
        openDrawer(scaffold.context);
      } else {
        scaffold.openDrawer();
      }
    }
  }
}
