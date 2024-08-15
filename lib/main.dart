import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasks_demo/firebase_options.dart';
import 'package:tasks_demo/utils/app_routes.dart';
import 'package:tasks_demo/logic/auth/auth_cubit.dart';
import 'package:tasks_demo/logic/task/task_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>(
          create: (_) => AuthCubit()..loadUserData(),
        ),
        BlocProvider<TaskCubit>(
          create: (_) => TaskCubit()..loadTasks(),
        ),
      ],
      child: MaterialApp(
        routes: AppRoutes.routes,
        initialRoute: AppRoutes.splash,
        title: 'Task Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
          useMaterial3: true,
        ),
      ),
    );
  }
}
