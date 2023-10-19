import 'package:climbing_app/core/widgets/custom_progress_indicator.dart';
import 'package:flutter/material.dart';

class SubmitButton extends StatelessWidget {
  final String text;
  final bool isActive;
  final bool isLoaded;
  final void Function() onPressed;

  const SubmitButton({
    super.key,
    required this.text,
    this.isActive = true,
    required this.isLoaded,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isLoaded && isActive ? onPressed : null,
      child: isLoaded ? Text(text) : const CustomProgressIndicator(),
    );
  }
}
