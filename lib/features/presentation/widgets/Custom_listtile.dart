import 'package:flutter/material.dart';
import 'package:todo_project/core/shared_widgets/custom_text.dart';

class CustomListtile extends StatelessWidget {
  const CustomListtile({
    super.key,
    this.title,
    this.subtitle,
    this.leading,
    this.tail,
    this.onTap,
  });

  final Widget? title;
  final Widget? subtitle;
  final Widget? leading;
  final Widget? tail;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 75,
      child: Card(
        child: ListTile(
          onTap: onTap,
          leading: leading, // ✅
          contentPadding: const EdgeInsets.symmetric(
            vertical: 5,
            horizontal: 20,
          ),
          tileColor: const Color.fromARGB(255, 250, 249, 249),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          trailing:
              tail ??
              IconButton(
                onPressed: onTap,
                icon: const Icon(
                  Icons.arrow_forward_ios,
                  color: Color(0xff63D9F3),
                  size: 20,
                  // ✅ حذفنا fontWeight
                ),
              ),
          title:
              title ??
              CustomText(
                text: "Client meeting",
                colorText: const Color.fromARGB(255, 13, 13, 13),
                fontWeight: FontWeight.bold, // ✅
              ),
          subtitle:
              subtitle ??
              CustomText(
                text: "Tomorrow | 10:30pm",
                fontSize: 14,
                colorText: Colors.black,
              ),
        ),
      ),
    );
  }
}
