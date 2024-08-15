import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasks_demo/logic/task/task_cubit.dart';
import 'package:tasks_demo/repository/models/task_model.dart';

class TaskCreationSheet extends StatefulWidget {
  const TaskCreationSheet({super.key});

  @override
  State<TaskCreationSheet> createState() => _TaskCreationSheetState();
}

class _TaskCreationSheetState extends State<TaskCreationSheet> {
  final TextEditingController _taskNameController = TextEditingController();

  final TextEditingController _taskDescriptionController =
      TextEditingController();
  bool buttonActive = false;
  @override
  void initState() {
    super.initState();
    _taskNameFocusNode.requestFocus();
  }

  onTaskNameChanged(val) {
    if (_taskNameController.text.isNotEmpty ||
        _taskDescriptionController.text.isNotEmpty) {
      setState(() {
        buttonActive = true;
      });
    } else {
      setState(() {
        buttonActive = false;
      });
    }
  }

  final FocusNode _taskNameFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            focusNode: _taskNameFocusNode,
            controller: _taskNameController,
            onChanged: onTaskNameChanged,
            decoration: InputDecoration(
              hintText: "Task Name",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: _taskDescriptionController,
            onChanged: onTaskNameChanged,
            decoration: InputDecoration(
              hintText: "Task Description",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        BlocConsumer<TaskCubit, TaskState>(
          listener: (context, state) {
            if (state is TaskDone) {
              Navigator.of(context).pop();
            }
          },
          builder: (context, state) {
            if (state is TaskLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: buttonActive
                    ? () {
                        context.read<TaskCubit>().addTask(
                              TaskModel(
                                title: _taskNameController.text,
                                description: _taskDescriptionController.text,
                              ),
                            );
                      }
                    : null,
                child: const Text("Add Task"),
              ),
            );
          },
        ),
      ],
    );
  }
}
