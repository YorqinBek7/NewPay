import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

part 'internet_checker_event.dart';
part 'internet_checker_state.dart';

class InternetCheckerBloc
    extends Bloc<InternetCheckerEvent, InternetCheckerState> {
  InternetCheckerBloc() : super(InternetCheckerHasInternet()) {
    on<InternetCheckerEvent>(tryToCheckInternet);
  }
  tryToCheckInternet(
      InternetCheckerEvent event, Emitter<InternetCheckerState> emit) async {
    if (event is InternetCheckerManagerEvent) {
      var isDeviceConnected = false;
      await for (var data in Connectivity().onConnectivityChanged) {
        if (data != ConnectivityResult.none) {
          isDeviceConnected = await InternetConnectionChecker().hasConnection;
          if (!isDeviceConnected) {
            emit(InternetCheckerHasNoInternet());
          } else {
            emit(InternetCheckerHasInternet());
          }
        } else if (data == ConnectivityResult.none) {
          emit(InternetCheckerHasNoInternet());
        }
      }
    }
  }
}
