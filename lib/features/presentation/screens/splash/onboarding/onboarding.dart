import 'package:flutter/material.dart';
import 'package:todo_project/core/theme/app_colors.dart';
import 'package:todo_project/features/presentation/screens/root/root_screen.dart';
import 'package:todo_project/features/presentation/screens/splash/onboarding/custom_pageView.dart';
import 'package:todo_project/task_repository.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({super.key, required this.repository});

  final TaskRepository repository;

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  final List<String> imgCard = [
    "assets/image1.png",
    "assets/image2.png",
    "assets/image3.png",
    "assets/image4.png",
  ];

  final PageController controller = PageController();
  int currentPage = 0;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void _nextPage() {
    if (currentPage < 3) {
      setState(() => currentPage++);
    }
    controller.animateToPage(
      currentPage,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  void _goToRoot() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => RootScreen(repository: widget.repository), // ✅
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter, // ✅
            end: Alignment.bottomCenter, // ✅
            colors: AppColors.ground,
          ),
        ),
        child: Column(
          children: [
            SizedBox(
              height: 570,
              child: CustomPageview(
                controller: controller,
                onPageChanged: (index) {
                  setState(() => currentPage = index);
                },
              ),
            ),
            Row(
              children: [
                const SizedBox(width: 220),

                // ── Dots indicator ────────────────────────────────────────
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: imgCard.asMap().entries.map((entry) {
                    return AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      width: currentPage == entry.key ? 16 : 8,
                      height: 8,
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: currentPage == entry.key
                            ? AppColors.textLight
                            : Colors.grey,
                      ),
                    );
                  }).toList(),
                ),

                const SizedBox(width: 145),

                // ── Next / Done button ────────────────────────────────────
                ElevatedButton(
                  // ✅ مش icon
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: const CircleBorder(),
                    padding: const EdgeInsets.all(14),
                  ),
                  onPressed: currentPage >= 3 ? _goToRoot : _nextPage, // ✅
                  child: Icon(
                    currentPage == 3 ? Icons.done : Icons.arrow_forward,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
