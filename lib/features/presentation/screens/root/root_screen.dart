import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_project/bloc/task_manager_bloc.dart';
import 'package:todo_project/core/shared_widgets/custom_bottombar.dart';
import 'package:todo_project/core/theme/app_colors.dart';
import 'package:todo_project/features/data/calender_screen.dart';
import 'package:todo_project/features/presentation/screens/calender/calender_page.dart';
import 'package:todo_project/features/presentation/screens/home/home_screen.dart';
import 'package:todo_project/features/presentation/screens/settings/setting_screen.dart';
import 'package:todo_project/features/presentation/screens/tasks/tasks_list/task_list_screen.dart';
import 'package:todo_project/task_repository.dart';

class RootScreen extends StatefulWidget {
  const RootScreen({super.key, required this.repository});

  final TaskRepository repository;

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  late CalendarViewModel _calendarVm;
  int _currentPage = 0;
  int _previousPage = 0;

  late final List<Widget> screens;

  @override
  void initState() {
    super.initState();
    _calendarVm = CalendarViewModel(widget.repository);

    screens = [
      HomeScreen(repository: widget.repository),
      TaskListScreen(repository: widget.repository),
      CalendarPage(viewModel: _calendarVm),
      const SettingsPage(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    // ✅ بتتبني من جديد كل مرة تغيري الـ tab

    return PopScope(
      canPop: false,
      child: BlocProvider(
        create: (_) => TaskManagerBloc(),
        child: BlocConsumer<TaskManagerBloc, TaskManagerState>(
          listener: (_, __) {},
          builder: (context, state) {
            return Scaffold(
              body: Container(
                height: double.infinity,
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: AppColors.ground,
                  ),
                ),
                child: screens[_currentPage], // ✅
              ),
              bottomNavigationBar: CustomBottomNavBar(
                currentIndex: _currentPage,
                onTap: (index) {
                  setState(() {
                    _previousPage = _currentPage;
                    _currentPage = index;
                  });
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
