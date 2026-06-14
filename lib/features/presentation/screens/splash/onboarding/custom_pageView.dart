import 'package:flutter/material.dart';
import 'package:todo_project/features/presentation/screens/splash/onboarding/custom_page.dart';

class CustomPageview extends StatefulWidget {
  const CustomPageview({
    super.key,
    required this.controller,
    required this.onPageChanged, // ✅
  });

  final PageController controller;
  final void Function(int) onPageChanged; // ✅ اتحفظت في الـ class

  @override
  State<CustomPageview> createState() => _CustomPageviewState();
}

class _CustomPageviewState extends State<CustomPageview> {
  int currentPage = 0;

  final List<String> titleText = [
    "Plan your tasks to do, that way you'll stay \n       organized and you won't skip any",
    "Make a full schedule for the whole week and stay \n            organized and productive all days",
    "create a team task, invite people \n and manage your work together",
    "You informations are secure with us",
  ];

  final List<String> imgCard = [
    "assets/image1.png",
    "assets/image2.png",
    "assets/image3.png",
    "assets/image4.png",
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 520,
          child: PageView.builder(
            physics: const NeverScrollableScrollPhysics(),
            controller: widget.controller,
            onPageChanged: (value) {
              setState(() => currentPage = value);
              widget.onPageChanged(value); // ✅ بيبعت الـ index للـ parent
            },
            itemBuilder: (context, index) {
              return CustomPage(
                imgPage: imgCard[index % imgCard.length],
                titleText: titleText[index % titleText.length],
              );
            },
          ),
        ),
      ],
    );
  }
}
