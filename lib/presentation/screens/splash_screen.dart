import 'package:flutter/material.dart';
import 'package:tasks_demo/utils/app_routes.dart';
import 'package:tasks_demo/repository/firebase_services/auth_services.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    getLandingPage();
  }

  Future<void> getLandingPage() async {
    await Future.delayed(const Duration(seconds: 2)).then((value) {
      if (AuthServices().currentUser != null) {
        Navigator.pushReplacementNamed(context, AppRoutes.home);
      } else {
        Navigator.pushReplacementNamed(context, AppRoutes.login);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Welcome to Task Demo!'),
      ),
    );
  }
}
