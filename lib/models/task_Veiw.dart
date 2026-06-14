import 'package:flutter/foundation.dart';
import 'package:todo_project/models/task_models.dart';
import 'package:todo_project/task_repository.dart';

class TaskDetailViewModel extends ChangeNotifier {
  TaskDetailViewModel(this._repo, TaskModel task) : _task = task;

  final TaskRepository _repo;
  TaskModel _task;

  TaskModel get task => _task;

  Future<void> markDone() async {
    await _repo.markDone(_task.id);
    _task = _task.copyWith(status: TaskStatus.done);
    notifyListeners();
  }

  Future<void> togglePin() async {
    await _repo.togglePin(_task.id);
    final next = _task.isPinned ? TaskStatus.pending : TaskStatus.pinned;
    _task = _task.copyWith(status: next);
    notifyListeners();
  }

  Future<void> deleteTask() => _repo.deleteTask(_task.id);
}
