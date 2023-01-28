import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_pay/data/service.dart';
part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  AuthService service = AuthService();
  SignUpBloc() : super(SignUpInitialState()) {
    on<SignUpEvent>(tryToRegister);
  }
  tryToRegister(SignUpEvent event, Emitter<SignUpState> emit) async {
    if (event is SignUpManagerEvent) {
      try {
        emit(SignUpLoadingState());
        await service
            .signUp(
              email: event.email,
              password: event.password,
            )
            .then(
              (value) => value.user!.updateDisplayName(event.name),
            );
        emit(SignUpSuccessState(email: event.email, password: event.password));
      } on FirebaseAuthException catch (e) {
        emit(SignUpErrorState(error: e.message ?? 'Unknown error'));
      }
    }
  }
}
