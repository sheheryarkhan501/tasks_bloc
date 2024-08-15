import 'package:tasks_demo/utils/app_enums.dart';

class TaskModel {
  String? title;
  String? description;
  String? id;
  TaskStatus? taskStatus;
  TaskModel({this.title, this.id, this.taskStatus, this.description});
  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      title: json['title'],
      description: json['description'],
      id: json['id'],
      taskStatus: json['taskStatus'] == 'completed'
          ? TaskStatus.completed
          : TaskStatus.pending,
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'id': id,
      'taskStatus':
          taskStatus == TaskStatus.completed ? 'completed' : 'pending',
    };
  }
}
