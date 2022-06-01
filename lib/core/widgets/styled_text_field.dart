import 'package:assorted_layout_widgets/assorted_layout_widgets.dart';
import 'package:climbing_app/app/theme/bloc/app_theme.dart';
import 'package:flutter/material.dart';

class StyledTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String? errorText;
  final String hintText;
  final TextInputAction inputAction;
  final bool isError;
  final TextInputType keyboardType;
  final int maxLines;
  final bool obscureText;
  final void Function()? onTap;
  final bool readOnly;
  final Widget? suffixIcon;
  final TextAlign textAlign;

  const StyledTextField({
    Key? key,
    required this.hintText,
    this.controller,
    this.errorText,
    this.inputAction = TextInputAction.next,
    this.isError = false,
    this.keyboardType = TextInputType.text,
    this.maxLines = 1,
    this.obscureText = false,
    this.onTap,
    this.readOnly = false,
    this.suffixIcon,
    this.textAlign = TextAlign.start,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colorTheme = AppTheme.of(context).colorTheme;
    final textTheme = AppTheme.of(context).textTheme;
    final border = OutlineInputBorder(
      borderRadius: const BorderRadius.all(Radius.circular(16)),
      borderSide: BorderSide(
        color: isError || errorText != null
            ? colorTheme.error
            : colorTheme.unselected,
        width: isError || errorText != null ? 2 : 1,
      ),
    );
    final focusedBorder = border.copyWith(
      borderSide: BorderSide(
        width: 2,
        color: isError || errorText != null
            ? colorTheme.error
            : colorTheme.primary,
      ),
    );

    return TextField(
      controller: controller,
      decoration: InputDecoration(
        enabledBorder: border,
        focusedBorder: focusedBorder,
        errorBorder: focusedBorder,
        // ignore: no-equal-arguments
        focusedErrorBorder: focusedBorder,
        contentPadding:
            Pad(left: 16, right: suffixIcon == null ? 16 : 0, vertical: 14.5),
        errorText: errorText,
        hintText: hintText,
        suffixIcon: suffixIcon,
      ),
      keyboardType: keyboardType,
      maxLines: maxLines,
      obscureText: obscureText,
      onTap: onTap,
      readOnly: readOnly,
      style: textTheme.body1Regular,
      textAlign: textAlign,
      textAlignVertical: TextAlignVertical.center,
      textInputAction: inputAction,
    );
  }
}
