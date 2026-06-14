import 'package:flutter/material.dart';
import 'package:todo_project/core/shared_widgets/custom_text.dart';

import '../theme/app_colors.dart';

class CustomAppButton extends StatelessWidget {
  const CustomAppButton({
    super.key,
    this.onTap,
    this.text,
    this.borderRadius,
    this.width,
    this.height,
    this.child,
    this.btnColor,
    this.textColor,
    this.borderColor,
    this.widget,
  });
  final VoidCallback? onTap;
  final String? text;
  final double? borderRadius;
  final double? width;
  final double? height;
  final Widget? child;
  final Color? btnColor, textColor, borderColor;
  final Widget? widget;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width ?? 150,
        height: height ?? 40,
        decoration: BoxDecoration(
          border: borderColor != null ? Border.all(color: borderColor!) : null,
          color: btnColor ?? AppColors.bgDark,
          borderRadius: borderRadius == null
              ? BorderRadius.circular(5)
              : BorderRadius.circular(borderRadius!),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child:
                child ??
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomText(
                      text: text ?? '',
                      colorText: textColor ?? Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.normal,
                    ),
                    // SizedBox(width: 5),
                    // widget ?? SizedBox.shrink(),
                  ],
                ),
          ),
        ),
      ),
    );
  }
}
