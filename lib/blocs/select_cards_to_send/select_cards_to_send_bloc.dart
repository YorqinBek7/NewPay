import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';

part 'select_cards_to_send_event.dart';
part 'select_cards_to_send_state.dart';

class SelectCardsBloc extends Bloc<SelectCardsEvent, SelectCardsState> {
  int index = 0;
  SelectCardsBloc() : super(SelectCardsInitialState()) {
    on<SelectCardsEvent>(tryToChangeCard);
  }
  tryToChangeCard(SelectCardsEvent event, Emitter<SelectCardsState> emit) {
    if (event is SelectCardsManagerEvent) {
      index = event.index;
      emit(SelectCardsChangedState());
      emit(SelectCardsInitialState());
    }
  }
}
