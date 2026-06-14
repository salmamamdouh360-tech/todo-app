import 'package:flutter/material.dart';
import 'package:todo_project/core/shared_widgets/custom_text.dart';

class CustomPage extends StatefulWidget {
  const CustomPage({super.key, required this.titleText, required this.imgPage});
  final String titleText;
  final String imgPage;

  @override
  State<CustomPage> createState() => _CustomPageState();
}

class _CustomPageState extends State<CustomPage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          SizedBox(height: 50),
          Image.asset(widget.imgPage, fit: BoxFit.cover, height: 300),
          SizedBox(height: 50),
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: CustomText(text: widget.titleText),
          ),
        ],
      ),
    );
  }
}
