import 'package:flutter/material.dart';
import 'package:tasks_demo/presentation/screens/home_screen.dart';
import 'package:tasks_demo/presentation/screens/login_screen.dart';
import 'package:tasks_demo/presentation/screens/register_screen.dart';
import 'package:tasks_demo/presentation/screens/splash_screen.dart';

class AppRoutes {
  static const splash = '/splash';
  static const home = '/home';
  static const login = '/login';
  static const register = '/register';
  static const task = '/task';
  static const taskDetail = '/task-detail';

  static Map<String, Widget Function(dynamic)> routes = {
    splash: (context) => const SplashScreen(),
    login: (context) => LoginScreen(),
    register: (context) => RegisterScreen(),
    // task: (context) => const TaskScreen(),
    // taskDetail: (context) => const TaskDetailScreen(),
    home: (context) => const HomeScreen(),
  };
}
