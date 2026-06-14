import 'package:flutter/material.dart';
import 'package:todo_project/core/shared_widgets/custom_text.dart';
import 'package:todo_project/core/theme/app_colors.dart';
import 'package:todo_project/features/presentation/widgets/Custom_listtile.dart';
import 'package:todo_project/features/presentation/widgets/bottom_sheet.dart';
import 'package:todo_project/models/task_models.dart';
import 'package:todo_project/task_repository.dart';

class TaskListScreen extends StatefulWidget {
  const TaskListScreen({super.key, required this.repository});

  final TaskRepository repository;

  @override
  State<TaskListScreen> createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  String _searchQuery = '';
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

  List<TaskModel> get _filteredTasks {
    if (_searchQuery.isEmpty) return _allTasks;
    return _allTasks
        .where(
          (t) => t.title.toLowerCase().contains(_searchQuery.toLowerCase()),
        )
        .toList();
  }

  Future<void> _markDone(TaskModel task) async {
    if (task.isDone) return;
    await widget.repository.markDone(task.id); // ✅
    _loadTasks();
  }

  Future<void> _deleteTask(String id) async {
    await widget.repository.deleteTask(id); // ✅
    _loadTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // ── Search + Sort ─────────────────────────────────────────────────
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  onChanged: (v) => setState(() => _searchQuery = v),
                  style: const TextStyle(color: AppColors.textLight),
                  decoration: InputDecoration(
                    suffixIcon: const Icon(
                      Icons.search,
                      color: AppColors.textMuted,
                    ),
                    fillColor: AppColors.bgCard,
                    filled: true,
                    hintText: "Search by task title",
                    hintStyle: const TextStyle(color: AppColors.textMuted),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              DropdownMenu<String>(
                width: 130,
                leadingIcon: const Icon(
                  Icons.sort,
                  size: 20,
                  color: AppColors.textLight,
                ),
                hintText: "Sort by",
                textStyle: const TextStyle(
                  color: AppColors.textLight,
                  fontSize: 13,
                ),
                dropdownMenuEntries: const [
                  DropdownMenuEntry(value: "date", label: "Date"),
                  DropdownMenuEntry(value: "title", label: "Title"),
                  DropdownMenuEntry(value: "status", label: "Status"),
                ],
                onSelected: (value) {
                  setState(() {
                    if (value == "title") {
                      _allTasks.sort((a, b) => a.title.compareTo(b.title));
                    } else if (value == "date") {
                      _allTasks.sort((a, b) => a.date.compareTo(b.date));
                    } else if (value == "status") {
                      // pending الأول ، done الآخر
                      _allTasks.sort(
                        (a, b) => a.status.index.compareTo(b.status.index),
                      );
                    }
                  });
                },
              ),
            ],
          ),
        ),

        // ── Title ─────────────────────────────────────────────────────────
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Align(
            alignment: Alignment.centerLeft,
            child: CustomText(text: "Tasks List"),
          ),
        ),
        const SizedBox(height: 10),

        // ── Task List ─────────────────────────────────────────────────────
        Expanded(
          child: _filteredTasks.isEmpty
              ? const Center(
                  child: Text(
                    'No tasks found',
                    style: TextStyle(color: AppColors.textMuted),
                  ),
                )
              : ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  itemCount: _filteredTasks.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemBuilder: (_, i) {
                    final task = _filteredTasks[i];
                    return CustomListtile(
                      // ✅ ضغطة على الـ tile تعمل complete
                      onTap: () => _markDone(task),
                      title: CustomText(
                        text: task.title,
                        colorText: task.isDone ? Colors.black38 : Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                      subtitle: CustomText(
                        text:
                            '${task.date.day}/${task.date.month}'
                            ' | ${task.time.hour}:${task.time.minute.toString().padLeft(2, '0')}',
                        fontSize: 13,
                        colorText: task.isDone
                            ? Colors.black26
                            : Colors.black54,
                      ),
                      // ✅ أيقونة بتتغير حسب الحالة
                      leading: task.isDone
                          ? const Icon(
                              Icons.verified_sharp,
                              color: Colors.green,
                              size: 28,
                            )
                          : const Icon(
                              Icons.radio_button_unchecked,
                              color: Colors.grey,
                              size: 28,
                            ),
                      // ✅ زرار حذف
                      tail: IconButton(
                        icon: const Icon(
                          Icons.delete_outline,
                          color: Colors.redAccent,
                          size: 22,
                        ),
                        onPressed: () => _deleteTask(task.id),
                      ),
                    );
                  },
                ),
        ),

        // ── Add Button ────────────────────────────────────────────────────
        Align(
          alignment: Alignment.centerRight,
          child: Padding(
            padding: const EdgeInsets.only(right: 20, bottom: 20, top: 10),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xff63D9F3),
                shape: const CircleBorder(),
                padding: const EdgeInsets.all(16),
              ),
              onPressed: () async {
                await CustomBtnSheet.displayCustomBtnSheet(
                  context,
                  repository: widget.repository,
                );
                _loadTasks();
              },
              child: const Icon(Icons.add, color: Colors.white, size: 25),
            ),
          ),
        ),
      ],
    );
  }
}
