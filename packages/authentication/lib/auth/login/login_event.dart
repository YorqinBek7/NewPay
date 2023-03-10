part of 'login_bloc.dart';

abstract class LoginEvent {}

class LoginManagerEvent extends LoginEvent {
  final String email;
  final String password;
  LoginManagerEvent({
    required this.email,
    required this.password,
  });
}
