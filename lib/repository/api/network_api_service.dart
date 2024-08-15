import 'dart:convert';
import 'dart:math';

import 'package:tasks_demo/mock/tasks_data.dart';
import 'package:tasks_demo/utils/api_endpoints.dart';
import 'package:tasks_demo/utils/base_api_service.dart';
import 'package:http/http.dart' as http;

TasksData tasksData = TasksData();

class NetworkApiService extends BaseApiService implements ApiEndpoints {
  int validTimeout = 2000;
  dynamic returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        return jsonDecode(response.body);

      case 400:
        throw Exception('Bad Request');
      case 401:
        throw Exception('Unauthorized');
      case 403:
        throw Exception('Forbidden');
      case 404:
        throw Exception('Not Found');
      case 500:
        throw Exception('Internal Server Error');
      default:
        throw Exception('Error');
    }
  }

  @override
  Future delete(String url, data) async {
    int timeout = await _generateTimeout();
    if (timeout > validTimeout) {
      throw Exception('Timeout');
    }
    if (url == ApiEndpoints.taskDelete) {
      http.Response response = tasksData.deleteTaskApi(jsonEncode(data));
      var responseJson = returnResponse(response);
      return responseJson;
    } else {
      throw Exception('endpoint not found');
    }
  }

  @override
  Future get(String url) async {
    int timeout = await _generateTimeout();
    if (timeout > validTimeout) {
      throw Exception('Timeout');
    }
    if (url == ApiEndpoints.tasks) {
      http.Response response = tasksData.getTasksApi();
      var responseJson = returnResponse(response);
      return responseJson;
    } else {
      throw Exception('endpoint not found');
    }
  }

  @override
  Future post(String url, data) async {
    int timeout = await _generateTimeout();
    if (timeout > validTimeout) {
      throw Exception('Timeout');
    }
    if (url == ApiEndpoints.taskCreate) {
      http.Response response = tasksData.addTaskApi(jsonEncode(data));
      var responseJson = returnResponse(response);
      return responseJson;
    } else if (url == ApiEndpoints.taskUpdate) {
      http.Response response = tasksData.updateTaskApi(jsonEncode(data));
      var responseJson = returnResponse(response);
      return responseJson;
    } else if (url == ApiEndpoints.taskReorder) {
      if (data['oldIndex'] == null || data['newIndex'] == null) {
        throw Exception('Bad Request');
      }
      http.Response response =
          tasksData.reorderTaskApi(data['oldIndex'], data['newIndex']);
      var responseJson = returnResponse(response);
      return responseJson;
    } else {
      throw Exception('endpoint not found');
    }
  }

  Future<int> _generateTimeout() async {
    int milliseconds = 500 + Random().nextInt(1500);
    await Future.delayed(Duration(milliseconds: milliseconds));
    return milliseconds;
  }

  @override
  Future put(String url, data) {
    throw UnimplementedError();
  }
}
