import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class CustomTextFormField extends StatefulWidget {
  const CustomTextFormField({
    super.key,
    required this.hintText,
    this.controller,
    this.onTapPasswordView,
    this.validator,
  });
  final String hintText;
  final TextEditingController? controller;
  final void Function()? onTapPasswordView;
  final FormFieldValidator<String>? validator;

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  bool _obscurePassword = true;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      validator: widget.validator,
      cursorColor: AppColors.bgDark,
      obscureText:
          widget.hintText.toLowerCase() == 'password' ||
              widget.hintText.toLowerCase() == 'confirm password'
          ? _obscurePassword
          : false,
      decoration: InputDecoration(
        filled: true,
        suffixIcon:
            widget.hintText.toLowerCase() == 'password' ||
                widget.hintText.toLowerCase() == 'confirm password'
            ? IconButton(
                onPressed: () {
                  if (widget.onTapPasswordView != null) {
                    widget.onTapPasswordView!();
                  } else {
                    setState(() {
                      _obscurePassword = !_obscurePassword;
                    });
                  }
                },
                icon: Icon(
                  _obscurePassword ? Icons.visibility_off : Icons.visibility,
                  color: AppColors.bgDark,
                ),
              )
            : null,
        fillColor: Colors.white,
        hintText: widget.hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
      ),
    );
  }
}
