import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(ThemeAutoState()) {
    on<ThemeEvent>(tryToChangeTheme);
  }
  int theme = 0;
  tryToChangeTheme(ThemeEvent event, Emitter<ThemeState> emit) {
    if (event is ThemeManagerEvent) {
      theme = event.themeState;

      switch (event.themeState) {
        case 0:
          emit(ThemeAutoState());
          break;
        case 1:
          emit(ThemeDarkState());
          break;
        case 2:
          emit(ThemeLightState());
          break;
      }
    }
  }
}
