import 'package:flutter/material.dart';

class AppTextFiled extends StatefulWidget {
  final Color color;
  final IconData prefixIcon;
  final String hintText;
  final TextEditingController c;
  AppTextFiled(this.hintText, this.prefixIcon, this.color, {required this.c});
  @override
  State<AppTextFiled> createState() => AppTextFiledState();
}

class AppTextFiledState extends State<AppTextFiled> {
  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: EdgeInsets.only(right: 35,left: 35,top: 30,bottom: 5),
      child: TextField(
        controller: widget.c,
        decoration: InputDecoration(
          hintText: (widget.hintText),
          hintStyle: TextStyle(color: Colors.grey),
          suffixIcon: Icon(widget.prefixIcon, color: widget.color),
          filled: true,
          fillColor: const Color.fromARGB(241, 255, 255, 255),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
        ),
      ),
    );
  }
}
