import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  const CustomText({
    super.key,
    this.text,
    this.style,
    this.fontSize,
    this.fontWeight,
    this.colorText,
  });
  final String? text;
  final TextStyle? style;
  final double? fontSize;
  final FontWeight? fontWeight;
  final Color? colorText;
  @override
  Widget build(BuildContext context) {
    return Text(
      text ?? "",
      style:
          style ??
          TextStyle(
            color: colorText ?? Colors.white,
            // add fontSize?? if it equal null take defult (18)
            fontSize: fontSize ?? 18,
            fontWeight: fontWeight ?? FontWeight.normal,
          ),
    );
  }
}
