import 'package:assorted_layout_widgets/assorted_layout_widgets.dart';
import 'package:climbing_app/app/theme/bloc/app_theme.dart';
import 'package:flutter/material.dart';

class StyledTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String hintText;
  final TextInputAction inputAction;
  final TextInputType keyboardType;
  final bool obscureText;
  final Widget? suffixIcon;

  const StyledTextField({
    Key? key,
    required this.hintText,
    this.controller,
    this.inputAction = TextInputAction.next,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.suffixIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(16)),
          borderSide: BorderSide(
            color: AppTheme.of(context).colorTheme.unselected,
          ),
        ),
        contentPadding: const Pad(horizontal: 16, vertical: 14.5),
        suffixIcon: suffixIcon,
        hintText: hintText,
      ),
      keyboardType: keyboardType,
      maxLines: 1,
      style: AppTheme.of(context).textTheme.body1Regular,
      textAlignVertical: TextAlignVertical.center,
      textInputAction: inputAction,
      obscureText: obscureText,
    );
  }
}
