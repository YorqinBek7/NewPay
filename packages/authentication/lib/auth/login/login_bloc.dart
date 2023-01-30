import 'package:authentication/auth/service/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  AuthService service = AuthService();
  LoginBloc() : super(LoginInitialState()) {
    on<LoginEvent>(tryToLogin);
  }
  tryToLogin(LoginEvent event, Emitter<LoginState> emit) async {
    if (event is LoginManagerEvent) {
      emit(LoginLoadingState());

      try {
        await service.logIn(email: event.email, password: event.password);
        emit(LoginSuccessState(email: event.email, password: event.password));
      } on FirebaseAuthException catch (e) {
        emit(LoginErrorState(error: e.message ?? 'error'));
      }
    }
  }
}
