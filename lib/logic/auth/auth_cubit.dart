import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tasks_demo/repository/firebase_services/auth_services.dart';
import 'package:tasks_demo/repository/models/user_model.dart';
import 'package:tasks_demo/utils/app_extension.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());
  final AuthServices _authServices = AuthServices();

  void loadUserData() async {
    if (_authServices.currentUser != null) {
      emit(AuthSuccess(UserModel.fromUser(_authServices.currentUser!)));
    } else {
      emit(AuthInitial());
    }
  }

  void login(String email, String password) async {
    emit(AuthLoading());
    final result = await _authServices.login(email, password);
    if (result is UserCredential) {
      return emit(AuthSuccess(UserModel.fromUser(result.user!)));
    } else {
      handleFirebaseAuthException(result);
    }
  }

  void register(String email, String password, String username) async {
    emit(AuthLoading());
    final result = await _authServices.register(email, password);
    if (result is UserCredential) {
      await result.user?.updateDisplayName(username);
      await FirebaseAuth.instance.currentUser!.reload();
      return emit(
          AuthSuccess(UserModel.fromUser(FirebaseAuth.instance.currentUser!)));
    } else {
      handleFirebaseAuthException(result);
    }
  }

  void handleFirebaseAuthException(dynamic result) async {
    if (result is FirebaseAuthException) {
      emit(AuthError(result.code.errorMessage));
    } else {
      emit(AuthError('An error occurred'));
    }
    await Future.delayed(const Duration(seconds: 2));
    emit(AuthInitial());
  }

  void signOut() {
    _authServices.signOut();
    emit(AuthInitial());
  }
}
