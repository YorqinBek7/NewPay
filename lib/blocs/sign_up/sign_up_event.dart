part of 'sign_up_bloc.dart';

@immutable
abstract class SignUpEvent {}

class SignUpManagerEvent extends SignUpEvent {
  String email;
  String password;
  String name;

  SignUpManagerEvent({
    required this.email,
    required this.password,
    required this.name,
  });
}
