import 'package:climbing_app/core/widgets/styled_text_field.dart';
import 'package:flutter/material.dart';

class StyledPasswordField extends StatefulWidget {
  final String hintText;
  final TextEditingController? controller;

  const StyledPasswordField({super.key, required this.hintText, this.controller});

  @override
  State<StatefulWidget> createState() => _StyledPasswordField();
}

class _StyledPasswordField extends State<StyledPasswordField> {
  bool obscureText = true;
  @override
  Widget build(BuildContext context) {
    return StyledTextField(
      controller: widget.controller,
      hintText: widget.hintText,
      keyboardType: TextInputType.visiblePassword,
      obscureText: obscureText,
      suffixIcon: GestureDetector(
        onTap: () => setState(() => obscureText = !obscureText),
        child: Icon(
          obscureText ? Icons.lock_outline_rounded : Icons.lock_open_rounded,
        ),
      ),
    );
  }
}
