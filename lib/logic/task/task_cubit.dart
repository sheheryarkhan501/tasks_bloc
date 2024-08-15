import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tasks_demo/repository/api/network_api_service.dart';
import 'package:tasks_demo/utils/api_endpoints.dart';
import 'package:tasks_demo/utils/app_enums.dart';
import 'package:tasks_demo/repository/models/task_model.dart';

part 'task_state.dart';

class TaskCubit extends Cubit<TaskState> {
  TaskCubit() : super(TaskInitial());
  List<TaskModel> tasks = [];
  NetworkApiService networkApiService = NetworkApiService();

  void addTask(TaskModel task) async {
    try {
      emit(const TaskLoading(message: 'Creating task...'));
      await networkApiService.post(ApiEndpoints.taskCreate, task.toJson());
      Fluttertoast.showToast(msg: "Task created successfully");
      emit(const TaskDone(message: 'Task created successfully'));
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
      emit(TaskError(message: e.toString()));
    } finally {
      await Future.delayed(const Duration(seconds: 1));
      loadTasks();
    }
  }

  void loadTasks() async {
    try {
      emit(const TaskLoading(message: 'Loading tasks...'));
      var data = await networkApiService.get(ApiEndpoints.tasks);
      tasks = (data as List).map((e) => TaskModel.fromJson(e)).toList();
      Fluttertoast.showToast(msg: "Tasks loaded successfully");
      emit(TaskLoaded(taskList: tasks));
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
      emit(TaskError(message: e.toString()));
    } finally {
      await Future.delayed(const Duration(seconds: 1));
      emit(TaskInitial());
    }
  }

  updateTask(TaskModel task, bool value) async {
    try {
      if (value) {
        task.taskStatus = TaskStatus.completed;
      } else {
        task.taskStatus = TaskStatus.pending;
      }
      emit(const TaskLoading(message: 'Updating task...'));
      await networkApiService.post(ApiEndpoints.taskUpdate, task.toJson());
      Fluttertoast.showToast(msg: "Task updated successfully");
      emit(TaskDone(message: 'Task updated successfully'));
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
      emit(TaskError(message: e.toString()));
    } finally {
      await Future.delayed(const Duration(seconds: 1));
      emit(TaskInitial());
      loadTasks();
    }
  }

  taskReorder(int oldIndex, int newIndex) async {
    try {
      TaskModel task = tasks.removeAt(oldIndex);
      if (newIndex > oldIndex) {
        newIndex -= 1;
      }
      emit(const TaskLoading(message: 'Reordering task...'));
      tasks.insert(newIndex, task);
      await networkApiService.post(ApiEndpoints.taskReorder,
          {'oldIndex': oldIndex, 'newIndex': newIndex});
      Fluttertoast.showToast(msg: "Task reordered successfully");
      emit(TaskDone(message: 'Task reordered successfully'));
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
      emit(TaskError(message: e.toString()));
    } finally {
      await Future.delayed(const Duration(seconds: 1));
      loadTasks();
    }
  }

  void deleteTask(TaskModel task) async {
    try {
      emit(TaskLoading(message: 'Deleting task'));
      await networkApiService.delete(ApiEndpoints.taskDelete, task.toJson());
      Fluttertoast.showToast(msg: "Task deleted successfully");
      emit(TaskDone(message: 'Task deleted successfully'));
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
      emit(TaskError(message: e.toString()));
    } finally {
      await Future.delayed(const Duration(seconds: 1));
      loadTasks();
    }
  }
}
