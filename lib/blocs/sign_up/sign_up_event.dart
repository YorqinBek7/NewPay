part of 'sign_up_bloc.dart';

@immutable
abstract class SignUpEvent {}

class SignUpManagerEvent extends SignUpEvent {
  String email;
  String password;

  SignUpManagerEvent({
    required this.email,
    required this.password,
  });
}
