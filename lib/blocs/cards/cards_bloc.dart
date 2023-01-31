import 'package:flutter/foundation.dart';
import 'package:new_pay/data/service.dart';
import 'package:new_pay/models/cards_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'cards_event.dart';
part 'cards_state.dart';

class CardsBloc extends Bloc<CardsEvent, CardsState> {
  CardsService cardsService = CardsService();

  CardsBloc() : super(CardsInitialState()) {
    on<CardsEvent>(getCards);
  }

  void getCards(CardsEvent event, Emitter<CardsState> emit) async {
    if (event is CardsGetEvent) {
      emit(CardsLoadingState());
      try {
        await for (var data in cardsService.getCards(event.userId)) {
          double sum = await cardsService.getAllSumFromCards(event.userId);
          double incomes = await cardsService.getIncomes(event.userId);
          double expenses = await cardsService.getExpenses(event.userId);
          emit(
            CardsSuccessState(
                cards: data,
                allSum: sum.toString(),
                expenses: expenses.toString(),
                incomes: incomes.toString()),
          );
        }
      } catch (e) {
        emit(CardsErrorState(error: e.toString()));
      }
    }
  }
}
