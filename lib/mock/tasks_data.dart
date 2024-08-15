import 'dart:convert';
import 'dart:math';

import 'package:http/http.dart' as http;
import 'package:tasks_demo/repository/models/task_model.dart';
import 'package:tasks_demo/utils/app_enums.dart';

class TasksData {
  bool isApiError = false;
  List<TaskModel> tasks = [];

  http.Response addTaskApi(String task) {
    TaskModel taskModel = TaskModel.fromJson(jsonDecode(task));
    taskModel.id = _generateRandomId();
    http.Response response = getResponse();
    if (response.statusCode == 200) {
      tasks.add(taskModel);
      return http.Response(jsonEncode(taskModel.toJson()), 200);
    }
    return response;
  }

  http.Response updateTaskApi(
    String task,
  ) {
    TaskModel taskModel = TaskModel.fromJson(jsonDecode(task));
    http.Response response = getResponse();
    if (response.statusCode == 200) {
      if (taskModel.taskStatus == TaskStatus.completed) {
        taskModel.taskStatus = TaskStatus.completed;
      } else {
        taskModel.taskStatus = TaskStatus.pending;
      }
      tasks = tasks.map((e) => e.id == taskModel.id ? taskModel : e).toList();
      return http.Response(jsonEncode(taskModel.toJson()), 200);
    }
    return response;
  }

  http.Response deleteTaskApi(String task) {
    TaskModel taskModel = TaskModel.fromJson(jsonDecode(task));
    http.Response response = getResponse();
    if (response.statusCode == 200) {
      tasks.removeWhere((element) => element.id == taskModel.id);
      return http.Response(task, 200);
    }
    return response;
  }

  http.Response reorderTaskApi(int oldIndex, int newIndex) {
    if (newIndex >= tasks.length || oldIndex >= tasks.length) {
      return http.Response('Bad request', 400);
    }
    List<TaskModel> tasksTemp = List<TaskModel>.from(tasks);
    http.Response response = getResponse();
    if (response.statusCode == 200) {
      TaskModel task = tasks.removeAt(oldIndex);
      // if (newIndex > oldIndex) {
      //   newIndex -= 1;
      // }
      tasks.insert(newIndex, task);
      return http.Response(jsonEncode(tasks), 200);
    } else {
      tasks = tasksTemp;
    }
    return response;
  }

  http.Response getTasksApi() {
    http.Response response = getResponse();
    if (response.statusCode == 200) {
      return http.Response(
          jsonEncode(tasks
              .map(
                (e) => e.toJson(),
              )
              .toList()),
          200);
    }
    return response;
  }

  String _generateRandomId() {
    return DateTime.now().millisecondsSinceEpoch.toString();
  }

  List<http.Response> responses = [
    http.Response('', 200),
    http.Response('Bad request', 400),
    http.Response('Forbidden', 403),
    http.Response('Internal Server Error', 500),
  ];

  http.Response getResponse() {
    if (isApiError) {
      return responses[Random().nextInt(responses.length)];
    }
    return responses[0];
  }
}
