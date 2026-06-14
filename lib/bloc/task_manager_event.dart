part of 'task_manager_bloc.dart';

@immutable
sealed class TaskManagerEvent {}

final class TaskManagerAddEvent extends TaskManagerEvent {
  final String task;
  TaskManagerAddEvent({required this.task});
}

final class TaskManagerDeleteEvent extends TaskManagerEvent {}

final class TaskManagerEditEvent extends TaskManagerEvent {
  final String nameTask;

  TaskManagerEditEvent({required this.nameTask});
}

final class TaskManagerPinEvent extends TaskManagerEvent {}
