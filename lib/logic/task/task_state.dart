part of 'task_cubit.dart';

@immutable
abstract class TaskState {
  const TaskState();
  List<TaskModel> get taskList => [];
}

class TaskInitial extends TaskState {}

class TaskLoading extends TaskState {
  const TaskLoading({required this.message});
  final String message;
}

class TaskDone extends TaskState {
  const TaskDone({required this.message});
  final String message;
}

class TaskLoaded extends TaskState {
  const TaskLoaded({required this.taskList});
  @override
  final List<TaskModel> taskList;
}

class TaskError extends TaskState {
  const TaskError({required this.message});
  final String message;
}
