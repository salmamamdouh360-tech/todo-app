import 'package:todo_project/models/task_models.dart';
import 'package:todo_project/servises/task_ser.dart';

/// Owns all task CRUD rules. ViewModels depend on this, never on the service.
class TaskRepository {
  TaskRepository(this._service);

  final TaskLocalService _service;

  List<TaskModel> getAllTasks() => _service.loadTasks();

  List<TaskModel> getTasksForDate(DateTime date) =>
      getAllTasks().where((t) => _isSameDay(t.date, date)).toList();

  Future<void> addTask(TaskModel task) async {
    final tasks = getAllTasks()..add(task);
    await _service.saveTasks(tasks);
  }

  Future<void> updateTask(TaskModel updated) async {
    final tasks = getAllTasks()
        .map((t) => t.id == updated.id ? updated : t)
        .toList();
    await _service.saveTasks(tasks);
  }

  Future<void> deleteTask(String id) async {
    final tasks = getAllTasks().where((t) => t.id != id).toList();
    await _service.saveTasks(tasks);
  }

  Future<void> markDone(String id) async {
    final tasks = getAllTasks().map((t) {
      if (t.id != id) return t;
      return t.copyWith(status: TaskStatus.done);
    }).toList();
    await _service.saveTasks(tasks);
  }

  Future<void> togglePin(String id) async {
    final tasks = getAllTasks().map((t) {
      if (t.id != id) return t;
      final next = t.isPinned ? TaskStatus.pending : TaskStatus.pinned;
      return t.copyWith(status: next);
    }).toList();
    await _service.saveTasks(tasks);
  }

  // ── Helpers ───────────────────────────────────────────────────────────────
  bool _isSameDay(DateTime a, DateTime b) =>
      a.year == b.year && a.month == b.month && a.day == b.day;

  /// Returns the set of dates that have at least one task.
  Set<DateTime> getDatesWithTasks() => getAllTasks()
      .map((t) => DateTime(t.date.year, t.date.month, t.date.day))
      .toSet();
}
