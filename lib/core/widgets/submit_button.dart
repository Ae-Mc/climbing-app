import 'package:flutter/material.dart';

class SubmitButton extends StatelessWidget {
  final String text;
  final bool isLoaded;
  final void Function() onPressed;

  const SubmitButton({
    Key? key,
    required this.text,
    required this.isLoaded,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isLoaded ? onPressed : null,
      child: isLoaded ? Text(text) : const CircularProgressIndicator.adaptive(),
    );
  }
}
