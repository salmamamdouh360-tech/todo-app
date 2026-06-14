part of 'task_manager_bloc.dart';

@immutable
sealed class TaskManagerState {}

final class TaskManagerInitialState extends TaskManagerState {}

final class TaskManagerLoadingState extends TaskManagerState {}

final class TaskManagerSucssesState extends TaskManagerState {}

final class TaskManagerfailureState extends TaskManagerState {
  final String messege;

  TaskManagerfailureState({required this.messege});
}
