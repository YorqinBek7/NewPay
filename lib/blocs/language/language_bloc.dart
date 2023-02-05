import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';

part 'language_event.dart';
part 'language_state.dart';

class LanguageBloc extends Bloc<LanguageEvent, LanguageState> {
  LanguageBloc() : super(LanguageInitial()) {
    on<LanguageManagerEvent>(tryToChangeLan);
  }
  tryToChangeLan(LanguageManagerEvent event, Emitter<LanguageState> emit) {
    emit(LanguageChanged());
    emit(LanguageInitial());
  }
}
