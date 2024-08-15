part of 'auth_cubit.dart';

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {
  AuthSuccess(this.userModel);
  final UserModel userModel;
}

class AuthError extends AuthState {
  AuthError(this.message);
  final String message;
}
