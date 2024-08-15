import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tasks_demo/logic/auth/auth_cubit.dart';
import 'package:tasks_demo/presentation/widgets/custom_button.dart';
import 'package:tasks_demo/utils/app_helpers.dart';
import 'package:tasks_demo/utils/app_routes.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthError) {
          Fluttertoast.showToast(
            msg: state.message,
          );
        }
        if (state is AuthSuccess) {
          Navigator.pushReplacementNamed(context, AppRoutes.home);
          emailController.clear();
          passwordController.clear();
        }
      },
      builder: (context, state) {
        return Scaffold(
            appBar: AppBar(),
            body: Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  child: Column(children: [
                    const SizedBox(height: 16),
                    const Text('Welcome to Task Demo!'),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: usernameController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Username is required';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        labelText: 'Username',
                      ),
                    ),
                    TextFormField(
                      controller: emailController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Email is required';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        labelText: 'Email',
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: passwordController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Password is required';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        labelText: 'Password',
                      ),
                    ),
                    const SizedBox(height: 16),
                    CustomButton(
                      text: 'Register',
                      status: AppHelpers.buttonStatusFromAuthState(state),
                      onPressed: () => handleRegister(context),
                    ),
                    const SizedBox(height: 16),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, AppRoutes.login);
                      },
                      child: const Text('Login'),
                    ),
                  ]),
                ),
              ),
            ));
      },
    );
  }

  void handleRegister(BuildContext context) {
    if (formKey.currentState!.validate()) {
      final email = emailController.text;
      final password = passwordController.text;
      context
          .read<AuthCubit>()
          .register(email, password, usernameController.text);
    }
  }
}
