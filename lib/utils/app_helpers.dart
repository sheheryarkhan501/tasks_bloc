import 'package:tasks_demo/utils/app_enums.dart';
import 'package:tasks_demo/logic/auth/auth_cubit.dart';
import 'package:tasks_demo/logic/task/task_cubit.dart';

class AppHelpers {
  static ButtonStatus buttonStatusFromAuthState(AuthState state) {
    if (state is AuthLoading) {
      return ButtonStatus.loading;
    } else if (state is AuthError) {
      return ButtonStatus.error;
    } else if (state is AuthSuccess) {
      return ButtonStatus.success;
    } else {
      return ButtonStatus.idle;
    }
  }

  static ButtonStatus buttonStatusFromTaskState(TaskState state) {
    if (state is TaskLoading) {
      return ButtonStatus.loading;
    } else if (state is TaskError) {
      return ButtonStatus.error;
    } else if (state is TaskDone) {
      return ButtonStatus.success;
    } else {
      return ButtonStatus.idle;
    }
  }
}
