part of 'sign_up_bloc.dart';

abstract class SignUpState {}

class SignUpInitialState extends SignUpState {}

class SignUpLoadingState extends SignUpState {}

class SignUpSuccessState extends SignUpState {
  final String email;
  final String password;
  SignUpSuccessState({
    required this.email,
    required this.password,
  });
}

class SignUpErrorState extends SignUpState {
  final String error;
  SignUpErrorState({required this.error});
}
