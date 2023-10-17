import 'package:assorted_layout_widgets/assorted_layout_widgets.dart';
import 'package:flutter/material.dart';

class InkWellCard extends StatelessWidget {
  final void Function() onTap;
  final Widget child;
  final ShapeBorder? Function(ShapeBorder? shape)? shapeModifier;

  const InkWellCard({
    super.key,
    required this.onTap,
    required this.child,
    this.shapeModifier,
  });

  @override
  Widget build(BuildContext context) {
    final shape = shapeModifier?.call(Theme.of(context).cardTheme.shape) ??
        Theme.of(context).cardTheme.shape;
    final borderRadius = (shape is RoundedRectangleBorder)
        ? shape.borderRadius.resolve(Directionality.of(context))
        : null;

    return Card(
      shape: shape,
      child: InkWell(
        borderRadius: borderRadius,
        onTap: onTap,
        child: Padding(
          padding: const Pad(horizontal: 16, vertical: 8),
          child: child,
        ),
      ),
    );
  }
}
