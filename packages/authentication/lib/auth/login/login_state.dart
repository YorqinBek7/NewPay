part of 'login_bloc.dart';

abstract class LoginState {}

class LoginInitialState extends LoginState {}

class LoginLoadingState extends LoginState {}

class LoginSuccessState extends LoginState {
  final String email;
  final String password;
  LoginSuccessState({
    required this.email,
    required this.password,
  });
}

class LoginErrorState extends LoginState {
  final String error;
  LoginErrorState({required this.error});
}
