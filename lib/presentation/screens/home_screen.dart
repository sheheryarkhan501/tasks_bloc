import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasks_demo/utils/app_enums.dart';

import 'package:tasks_demo/utils/app_helpers.dart';
import 'package:tasks_demo/logic/auth/auth_cubit.dart';
import 'package:tasks_demo/logic/task/task_cubit.dart';
import 'package:tasks_demo/presentation/widgets/custom_button.dart';
import 'package:tasks_demo/presentation/widgets/dialogs/task_creation_sheet.dart';
import 'package:tasks_demo/presentation/widgets/empty_task_widget.dart';
import 'package:tasks_demo/repository/models/task_model.dart';
import 'package:tasks_demo/utils/app_routes.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(state is AuthSuccess
                ? "Welcome ${state.userModel.name}"
                : "Welcome"),
            actions: [
              IconButton(
                onPressed: () {
                  context.read<AuthCubit>().signOut();
                  Navigator.pushReplacementNamed(context, AppRoutes.splash);
                },
                icon: const Icon(Icons.logout),
              ),
            ],
          ),
          floatingActionButton: BlocBuilder<TaskCubit, TaskState>(
            builder: (context, state) {
              if (state is TaskLoaded || state is TaskInitial) {
                return FloatingActionButton.extended(
                    onPressed: () {
                      _showTaskCreationSheet(context);
                    },
                    label: const Text("Add Task"),
                    icon: const Icon(Icons.add));
              }
              return const SizedBox.shrink();
            },
          ),
          body: BlocBuilder<TaskCubit, TaskState>(
            builder: (context, state) {
              return Column(
                children: [
                  Expanded(
                    child: context.read<TaskCubit>().tasks.isNotEmpty
                        ? ReorderableListView.builder(
                            onReorder: (oldIndex, newIndex) => {
                              context
                                  .read<TaskCubit>()
                                  .taskReorder(oldIndex, newIndex)
                            },
                            itemCount: context.read<TaskCubit>().tasks.length,
                            itemBuilder: (context, index) {
                              TaskModel task =
                                  context.read<TaskCubit>().tasks[index];
                              return ListTile(
                                key: Key('$index'),
                                leading: Checkbox(
                                  value:
                                      task.taskStatus == TaskStatus.completed,
                                  onChanged: (value) {
                                    context
                                        .read<TaskCubit>()
                                        .updateTask(task, value ?? false);
                                  },
                                ),
                                title: Text(task.title ?? ''),
                                subtitle: Text(task.description ?? ''),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        showGeneralDialog(
                                            context: context,
                                            pageBuilder:
                                                (context, anim1, anim2) {
                                              return AlertDialog(
                                                title:
                                                    const Text("Delete Task"),
                                                content: const Text(
                                                    'Are you sure you want to delete this task?'),
                                                actions: [
                                                  TextButton(
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                    child: const Text("Cancel"),
                                                  ),
                                                  TextButton(
                                                    onPressed: () {
                                                      context
                                                          .read<TaskCubit>()
                                                          .deleteTask(task);
                                                      Navigator.pop(context);
                                                    },
                                                    child: const Text("Delete"),
                                                  ),
                                                ],
                                              );
                                            });
                                      },
                                      icon: const Icon(Icons.delete),
                                    ),
                                    ReorderableDragStartListener(
                                      key: ValueKey(index),
                                      index: index,
                                      child: const Icon(Icons.drag_handle),
                                    ),
                                  ],
                                ),
                              );
                            },
                          )
                        : const EmptyTaskWidget(),
                  ),
                  if (state is TaskLoading ||
                      state is TaskDone ||
                      state is TaskError)
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: CustomButton(
                        status: AppHelpers.buttonStatusFromTaskState(state),
                        loadingText: getMessage(state),
                        text: "",
                      ),
                    )
                ],
              );
            },
          ),
        );
      },
    );
  }

  String getMessage(TaskState state) {
    if (state is TaskLoading) {
      return state.message;
    } else if (state is TaskError) {
      return state.message;
    } else if (state is TaskDone) {
      return state.message;
    } else {
      return "";
    }
  }

  void _showTaskCreationSheet(BuildContext context) {
    showModalBottomSheet(
      isScrollControlled: true,
      enableDrag: true,
      context: context,
      builder: (_) {
        return SizedBox(
          height: MediaQuery.of(context).size.height / 3 +
              MediaQuery.of(context).viewInsets.bottom,
          child: Padding(
            padding: EdgeInsets.only(
                top: 10,
                left: 10,
                right: 10,
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: const TaskCreationSheet(),
          ),
        );
      },
    );
  }
}
