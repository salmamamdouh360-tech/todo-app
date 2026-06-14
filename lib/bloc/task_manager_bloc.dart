import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'task_manager_event.dart';
part 'task_manager_state.dart';

class TaskManagerBloc extends Bloc<TaskManagerEvent, TaskManagerState> {
  TaskManagerBloc() : super(TaskManagerInitialState()) {
    on<TaskManagerEvent>((event, emit) {
      emit(TaskManagerLoadingState());
      try {
        emit(TaskManagerSucssesState());
      } catch (e) {
        // String errorMessage;
        // if (e is Exception) {
        //   errorMessage = e.toString().replaceFirst("Exception: ", "");
        // } else {
        //   errorMessage = "Something went wrong";
        // }

        emit(TaskManagerfailureState(messege: e.toString()));
      }
    });
  }
}
