import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_project/models/task_models.dart';

/// Low-level persistence layer. Only touches SharedPreferences.
class TaskLocalService {
  TaskLocalService(this._prefs);

  final SharedPreferences _prefs;

  List<TaskModel> loadTasks() {
    final raw = _prefs.getString(PrefsKeys.tasksJson);
    if (raw == null || raw.isEmpty) return [];
    try {
      return TaskModel.listFromJson(raw);
    } catch (_) {
      return [];
    }
  }

  Future<void> saveTasks(List<TaskModel> tasks) async {
    await _prefs.setString(PrefsKeys.tasksJson, TaskModel.listToJson(tasks));
  }

  Future<void> clearTasks() => _prefs.remove(PrefsKeys.tasksJson);
}

class PrefsKeys {
  PrefsKeys._();

  static const String tasksJson = 'tasks_json';
}
