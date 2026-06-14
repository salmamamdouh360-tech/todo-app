import 'package:flutter/material.dart';
import 'package:todo_project/models/task_models.dart';
import 'package:todo_project/task_repository.dart';

class CalendarViewModel extends ChangeNotifier {
  CalendarViewModel(this._repo) {
    _focusedMonth = DateTime(DateTime.now().year, DateTime.now().month);
    _selectedDate = DateTime.now();
    _refresh();
  }

  final TaskRepository _repo;

  late DateTime _focusedMonth;
  late DateTime _selectedDate;
  List<TaskModel> _tasksForSelected = [];
  Set<DateTime> _datesWithTasks = {};

  DateTime get focusedMonth => _focusedMonth;
  DateTime get selectedDate => _selectedDate;
  List<TaskModel> get tasks => _tasksForSelected;
  Set<DateTime> get busyDates => _datesWithTasks;

  // ── Navigation ────────────────────────────────────────────────────────────
  void previousMonth() {
    _focusedMonth = DateTime(_focusedMonth.year, _focusedMonth.month - 1);
    notifyListeners();
  }

  void nextMonth() {
    _focusedMonth = DateTime(_focusedMonth.year, _focusedMonth.month + 1);
    notifyListeners();
  }

  void selectDate(DateTime date) {
    _selectedDate = date;
    _tasksForSelected = _repo.getTasksForDate(date);
    notifyListeners();
  }

  // ── CRUD ──────────────────────────────────────────────────────────────────
  Future<void> addTask(String title) async {
    if (title.trim().isEmpty) return;
    final task = TaskModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: title.trim(),
      description: '',
      date: _selectedDate,
      time: TimeOfDay.now(),
    );
    await _repo.addTask(task);
    _refresh();
  }

  Future<void> deleteTask(String id) async {
    await _repo.deleteTask(id);
    _refresh();
  }

  // ── Refresh ───────────────────────────────────────────────────────────────
  void _refresh() {
    _tasksForSelected = _repo.getTasksForDate(_selectedDate);
    _datesWithTasks = _repo.getDatesWithTasks();
    notifyListeners();
  }
}
