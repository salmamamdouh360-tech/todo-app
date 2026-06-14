// import 'package:firebase_core/firebase_core.dart';

// import 'package:flutter/material.dart';
// import 'package:todo_project/features/presentation/screens/settings/setting_screen.dart';

// import 'package:todo_project/features/presentation/screens/splash/onboarding/onboarding.dart';
// import 'package:todo_project/firebase_options.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized;
//   await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       // theme: AppTheme.darkTheme
//       debugShowCheckedModeBanner: false,
//       home: Onboarding(),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_project/core/theme/app_theme.dart';
import 'package:todo_project/features/presentation/screens/splash/onboarding/onboarding.dart';
import 'package:todo_project/servises/task_ser.dart';
import 'package:todo_project/task_repository.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final prefs = await SharedPreferences.getInstance();
  final service = TaskLocalService(prefs);
  final repository = TaskRepository(service);

  runApp(TaskApp(repository: repository));
}

class TaskApp extends StatelessWidget {
  const TaskApp({super.key, required this.repository});

  final TaskRepository repository;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task Manager',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.dark,
      home: Onboarding(repository: repository),
    );
  }
}
