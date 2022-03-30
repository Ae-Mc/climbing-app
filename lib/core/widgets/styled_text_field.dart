import 'package:assorted_layout_widgets/assorted_layout_widgets.dart';
import 'package:climbing_app/app/theme/bloc/app_theme.dart';
import 'package:flutter/material.dart';

class StyledTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String hintText;
  final TextInputAction inputAction;
  final TextInputType keyboardType;
  final int maxLines;
  final bool obscureText;
  final void Function()? onTap;
  final bool readOnly;
  final Widget? suffixIcon;

  const StyledTextField({
    Key? key,
    required this.hintText,
    this.controller,
    this.inputAction = TextInputAction.next,
    this.keyboardType = TextInputType.text,
    this.maxLines = 1,
    this.obscureText = false,
    this.onTap,
    this.readOnly = false,
    this.suffixIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colorTheme = AppTheme.of(context).colorTheme;
    final textTheme = AppTheme.of(context).textTheme;

    return TextField(
      controller: controller,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(16)),
          borderSide: BorderSide(color: colorTheme.unselected),
        ),
        contentPadding:
            Pad(left: 16, right: suffixIcon == null ? 16 : 0, vertical: 14.5),
        suffixIcon: suffixIcon,
        hintText: hintText,
      ),
      keyboardType: keyboardType,
      maxLines: maxLines,
      onTap: onTap,
      readOnly: readOnly,
      style: textTheme.body1Regular,
      textAlignVertical: TextAlignVertical.center,
      textInputAction: inputAction,
      obscureText: obscureText,
    );
  }
}
