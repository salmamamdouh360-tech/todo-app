import 'package:flutter/material.dart';
import 'package:todo_project/core/shared_widgets/custom_text.dart';
import 'package:todo_project/features/presentation/widgets/Custom_listtile.dart';
import 'package:todo_project/models/task_models.dart';
import 'package:todo_project/task_repository.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.repository});

  final TaskRepository repository;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<TaskModel> _allTasks = [];

  @override
  void initState() {
    super.initState();
    _loadTasks();
  }

  void _loadTasks() {
    if (!mounted) return;
    setState(() {
      _allTasks = widget.repository.getAllTasks();
    });
  }

  Future<void> _markDone(TaskModel task) async {
    if (task.isDone) return;
    await widget.repository.markDone(task.id); // ✅
    _loadTasks();
  }

  @override
  Widget build(BuildContext context) {
    final incomplete = _allTasks.where((t) => !t.isDone).toList();
    final complete = _allTasks.where((t) => t.isDone).toList();

    return SingleChildScrollView(
      // ✅ عشان مش يـoverflow
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Header ───────────────────────────────────────────────────────
          Row(
            children: const [
              Spacer(),
              Icon(Icons.notifications_active, color: Colors.white),
            ],
          ),
          const SizedBox(height: 16),

          // ── Incomplete ────────────────────────────────────────────────────
          const CustomText(text: "Incomplete Tasks"),
          const SizedBox(height: 16),

          if (incomplete.isEmpty)
            const Center(
              child: Text(
                'No incomplete tasks 🎉',
                style: TextStyle(color: Colors.white54),
              ),
            )
          else
            ...incomplete.map(
              (task) => Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: CustomListtile(
                  onTap: () => _markDone(task), // ✅ complete بضغطة
                  leading: const Icon(
                    Icons.radio_button_unchecked,
                    color: Colors.grey,
                    size: 28,
                  ),
                  title: CustomText(
                    text: task.title,
                    colorText: const Color.fromARGB(255, 13, 13, 13),
                    fontWeight: FontWeight.bold,
                  ),
                  subtitle: CustomText(
                    text:
                        '${_formatDate(task.date)} | ${_formatTime(task.time)}',
                    fontSize: 14,
                    colorText: Colors.black,
                  ),
                ),
              ),
            ),

          const SizedBox(height: 16),

          // ── Complete ──────────────────────────────────────────────────────
          const CustomText(text: "Complete Tasks"),
          const SizedBox(height: 16),

          if (complete.isEmpty)
            const Center(
              child: Text(
                'No completed tasks yet',
                style: TextStyle(color: Colors.white54),
              ),
            )
          else
            ...complete.map(
              (task) => Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: CustomListtile(
                  leading: const Icon(
                    Icons.verified_sharp,
                    size: 28,
                    color: Colors.green, // ✅
                  ),
                  title: CustomText(
                    text: task.title,
                    colorText: Colors.black38, // ✅ باهت عشان completed
                    fontWeight: FontWeight.bold,
                  ),
                  subtitle: CustomText(
                    text:
                        '${_formatDate(task.date)} | ${_formatTime(task.time)}',
                    fontSize: 14,
                    colorText: Colors.black26,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  // ── Helpers ───────────────────────────────────────────────────────────────
  String _formatDate(DateTime d) => '${d.day}/${d.month}/${d.year}';

  String _formatTime(TimeOfDay t) {
    final h = t.hourOfPeriod.toString().padLeft(2, '0');
    final m = t.minute.toString().padLeft(2, '0');
    final period = t.period == DayPeriod.am ? 'am' : 'pm';
    return '$h:$m$period';
  }
}
