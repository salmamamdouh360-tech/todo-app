import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class CustomBottomNavBar extends StatefulWidget {
  final int currentIndex;
  final Function(int)? onTap;
  final Color? selectedItemColor;
  final Color? unselectedItemColor;

  const CustomBottomNavBar({
    super.key,
    required this.currentIndex,
    this.onTap,
    this.selectedItemColor,
    this.unselectedItemColor,
  });

  @override
  State<CustomBottomNavBar> createState() => _CustomBottomNavBarState();
}

class _CustomBottomNavBarState extends State<CustomBottomNavBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      decoration: const BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
        // boxShadow: [BoxShadow(blurRadius: 10, color: Colors.black12)],
      ),
      child: BottomNavigationBar(
        currentIndex: widget.currentIndex,
        onTap: widget.onTap,
        elevation: 0,
        backgroundColor: AppColors.bgDark,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: widget.selectedItemColor ?? Color(0xff63D9F3),
        unselectedItemColor: widget.unselectedItemColor ?? Colors.white,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home, size: 30), label: ""),
          BottomNavigationBarItem(
            icon: Icon(Icons.format_list_numbered, size: 30),
            label: "",
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month_outlined, size: 30),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings, size: 30),
            label: "",
          ),
        ],
      ),
    );
  }
}
